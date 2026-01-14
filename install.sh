#!/bin/bash
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Detect OS and architecture
detect_platform() {
    OS="$(uname -s)"
    ARCH="$(uname -m)"

    case "$OS" in
        Linux*)  PLATFORM="linux" ;;
        Darwin*) PLATFORM="macos" ;;
        *)       log_error "Unsupported OS: $OS"; exit 1 ;;
    esac

    case "$ARCH" in
        x86_64)  ARCH="amd64" ;;
        aarch64) ARCH="arm64" ;;
        arm64)   ARCH="arm64" ;;
        *)       log_error "Unsupported architecture: $ARCH"; exit 1 ;;
    esac

    log_info "Detected platform: $PLATFORM ($ARCH)"
}

# Get shell config file
get_shell_config() {
    if [ -n "$ZSH_VERSION" ] || [ "$SHELL" = "/bin/zsh" ]; then
        SHELL_CONFIG="$HOME/.zshrc"
    else
        SHELL_CONFIG="$HOME/.bashrc"
    fi
    log_info "Using shell config: $SHELL_CONFIG"
}

# Add to PATH if not already present
add_to_path() {
    local path_entry="$1"
    if ! grep -q "$path_entry" "$SHELL_CONFIG" 2>/dev/null; then
        echo "export PATH=\"\$PATH:$path_entry\"" >> "$SHELL_CONFIG"
        export PATH="$PATH:$path_entry"
        log_info "Added $path_entry to PATH"
    fi
}

# Install system dependencies
install_dependencies() {
    log_info "Installing system dependencies..."

    if [ "$PLATFORM" = "linux" ]; then
        if command -v apt-get &> /dev/null; then
            sudo apt-get update
            sudo apt-get install -y curl git unzip tar gzip fontconfig
        elif command -v dnf &> /dev/null; then
            sudo dnf install -y curl git unzip tar gzip fontconfig
        elif command -v pacman &> /dev/null; then
            sudo pacman -Sy --noconfirm curl git unzip tar gzip fontconfig
        fi
    elif [ "$PLATFORM" = "macos" ]; then
        # macOS has curl, git, tar built-in
        if ! command -v git &> /dev/null; then
            log_info "Installing Xcode Command Line Tools..."
            xcode-select --install 2>/dev/null || true
        fi
    fi
}

# Check if we can use sudo
can_sudo() {
    if sudo -n true 2>/dev/null; then
        return 0
    else
        return 1
    fi
}

# Install Neovim
install_neovim() {
    if command -v nvim &> /dev/null; then
        log_info "Neovim already installed: $(nvim --version | head -1)"
        return
    fi

    log_info "Installing Neovim..."

    local nvim_version="v0.11.0"
    local nvim_url=""
    local install_dir=""

    # Use /opt/nvim if we have sudo, otherwise use ~/.local
    if can_sudo; then
        install_dir="/opt/nvim"
    else
        install_dir="$HOME/.local/nvim"
        log_info "No sudo access, installing to $install_dir"
    fi

    if [ "$PLATFORM" = "linux" ]; then
        nvim_url="https://github.com/neovim/neovim/releases/download/${nvim_version}/nvim-linux64.tar.gz"
    elif [ "$PLATFORM" = "macos" ]; then
        nvim_url="https://github.com/neovim/neovim/releases/download/${nvim_version}/nvim-macos-${ARCH}.tar.gz"
    fi

    cd /tmp
    curl -LO "$nvim_url"

    if can_sudo; then
        sudo rm -rf "$install_dir"
        sudo mkdir -p "$install_dir"
        sudo tar -C "$install_dir" --strip-components=1 -xzf "$(basename $nvim_url)"
    else
        rm -rf "$install_dir"
        mkdir -p "$install_dir"
        tar -C "$install_dir" --strip-components=1 -xzf "$(basename $nvim_url)"
    fi

    rm -f "$(basename $nvim_url)"

    add_to_path "$install_dir/bin"
    export PATH="$PATH:$install_dir/bin"

    log_info "Neovim installed: $(nvim --version | head -1)"
}

# Install Nerd Font (Hack)
install_nerd_font() {
    log_info "Installing Hack Nerd Font..."

    local font_dir=""
    if [ "$PLATFORM" = "macos" ]; then
        font_dir="$HOME/Library/Fonts"
    else
        font_dir="$HOME/.local/share/fonts"
    fi

    mkdir -p "$font_dir"

    # Check if already installed
    if ls "$font_dir"/Hack*.ttf &> /dev/null; then
        log_info "Hack Nerd Font already installed"
        return
    fi

    cd /tmp
    local font_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hack.zip"
    curl -LO "$font_url"
    unzip -o Hack.zip -d "$font_dir"
    rm -f Hack.zip

    # Refresh font cache on Linux
    if [ "$PLATFORM" = "linux" ] && command -v fc-cache &> /dev/null; then
        fc-cache -fv
    fi

    log_info "Hack Nerd Font installed to $font_dir"
}

# Install fzf
install_fzf() {
    if command -v fzf &> /dev/null; then
        log_info "fzf already installed"
        return
    fi

    log_info "Installing fzf..."

    if [ -d "$HOME/.fzf" ]; then
        rm -rf "$HOME/.fzf"
    fi

    git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
    "$HOME/.fzf/install" --all --no-bash --no-zsh --no-fish

    # Add fzf to shell
    if ! grep -q "fzf" "$SHELL_CONFIG" 2>/dev/null; then
        echo '[ -f ~/.fzf.bash ] && source ~/.fzf.bash' >> "$SHELL_CONFIG"
        echo '[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh' >> "$SHELL_CONFIG"
    fi

    add_to_path "$HOME/.fzf/bin"

    log_info "fzf installed"
}

# Install ripgrep
install_ripgrep() {
    if command -v rg &> /dev/null; then
        log_info "ripgrep already installed"
        return
    fi

    log_info "Installing ripgrep..."

    local rg_version="14.1.1"
    local rg_url=""
    local rg_file=""
    local bin_dir=""

    if can_sudo; then
        bin_dir="/usr/local/bin"
    else
        bin_dir="$HOME/.local/bin"
        mkdir -p "$bin_dir"
        add_to_path "$bin_dir"
    fi

    if [ "$PLATFORM" = "linux" ]; then
        if [ "$ARCH" = "amd64" ]; then
            rg_file="ripgrep-${rg_version}-x86_64-unknown-linux-musl"
        else
            rg_file="ripgrep-${rg_version}-aarch64-unknown-linux-gnu"
        fi
    elif [ "$PLATFORM" = "macos" ]; then
        if [ "$ARCH" = "amd64" ]; then
            rg_file="ripgrep-${rg_version}-x86_64-apple-darwin"
        else
            rg_file="ripgrep-${rg_version}-aarch64-apple-darwin"
        fi
    fi

    rg_url="https://github.com/BurntSushi/ripgrep/releases/download/${rg_version}/${rg_file}.tar.gz"

    cd /tmp
    curl -LO "$rg_url"
    tar -xzf "${rg_file}.tar.gz"

    if can_sudo; then
        sudo mkdir -p "$bin_dir"
        sudo cp "${rg_file}/rg" "$bin_dir/"
    else
        cp "${rg_file}/rg" "$bin_dir/"
    fi

    rm -rf "${rg_file}" "${rg_file}.tar.gz"

    log_info "ripgrep installed"
}

# Install fd (find alternative)
install_fd() {
    if command -v fd &> /dev/null; then
        log_info "fd already installed"
        return
    fi

    log_info "Installing fd..."

    local fd_version="10.2.0"
    local fd_url=""
    local fd_file=""
    local bin_dir=""

    if can_sudo; then
        bin_dir="/usr/local/bin"
    else
        bin_dir="$HOME/.local/bin"
        mkdir -p "$bin_dir"
        add_to_path "$bin_dir"
    fi

    if [ "$PLATFORM" = "linux" ]; then
        if [ "$ARCH" = "amd64" ]; then
            fd_file="fd-v${fd_version}-x86_64-unknown-linux-musl"
        else
            fd_file="fd-v${fd_version}-aarch64-unknown-linux-gnu"
        fi
    elif [ "$PLATFORM" = "macos" ]; then
        if [ "$ARCH" = "amd64" ]; then
            fd_file="fd-v${fd_version}-x86_64-apple-darwin"
        else
            fd_file="fd-v${fd_version}-aarch64-apple-darwin"
        fi
    fi

    fd_url="https://github.com/sharkdp/fd/releases/download/v${fd_version}/${fd_file}.tar.gz"

    cd /tmp
    curl -LO "$fd_url"
    tar -xzf "${fd_file}.tar.gz"

    if can_sudo; then
        sudo mkdir -p "$bin_dir"
        sudo cp "${fd_file}/fd" "$bin_dir/"
    else
        cp "${fd_file}/fd" "$bin_dir/"
    fi

    rm -rf "${fd_file}" "${fd_file}.tar.gz"

    log_info "fd installed"
}

# Install Go
install_go() {
    if command -v go &> /dev/null; then
        log_info "Go already installed: $(go version)"
        return
    fi

    log_info "Installing Go..."

    local go_version="1.23.4"
    local go_url=""
    local install_dir=""

    if can_sudo; then
        install_dir="/usr/local"
    else
        install_dir="$HOME/.local"
        log_info "No sudo access, installing Go to $install_dir"
    fi

    if [ "$PLATFORM" = "linux" ]; then
        go_url="https://go.dev/dl/go${go_version}.linux-${ARCH}.tar.gz"
    elif [ "$PLATFORM" = "macos" ]; then
        go_url="https://go.dev/dl/go${go_version}.darwin-${ARCH}.tar.gz"
    fi

    cd /tmp
    curl -LO "$go_url"

    if can_sudo; then
        sudo rm -rf "$install_dir/go"
        sudo tar -C "$install_dir" -xzf "$(basename $go_url)"
    else
        rm -rf "$install_dir/go"
        mkdir -p "$install_dir"
        tar -C "$install_dir" -xzf "$(basename $go_url)"
    fi

    rm -f "$(basename $go_url)"

    add_to_path "$install_dir/go/bin"
    export PATH="$PATH:$install_dir/go/bin"

    # Add GOPATH/bin
    mkdir -p "$HOME/go/bin"
    add_to_path "$HOME/go/bin"
    export PATH="$PATH:$HOME/go/bin"

    log_info "Go installed: $(go version)"
}

# Install golangci-lint
install_golangci_lint() {
    if command -v golangci-lint &> /dev/null; then
        log_info "golangci-lint already installed"
        return
    fi

    log_info "Installing golangci-lint..."

    mkdir -p "$(go env GOPATH)/bin"
    curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b "$(go env GOPATH)/bin"

    log_info "golangci-lint installed"
}

# Install Node.js via nvm
install_nodejs() {
    if [ -d "$HOME/.nvm" ]; then
        log_info "nvm already installed"
    else
        log_info "Installing nvm..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
    fi

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    if ! command -v node &> /dev/null; then
        log_info "Installing Node.js 20..."
        nvm install 20
        nvm use 20
    else
        log_info "Node.js already installed: $(node --version)"
    fi
}

# Install Packer (Neovim plugin manager)
install_packer() {
    local packer_dir="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"

    if [ -d "$packer_dir" ]; then
        log_info "Packer already installed"
        return
    fi

    log_info "Installing Packer..."
    git clone --depth 1 https://github.com/wbthomason/packer.nvim "$packer_dir"
    log_info "Packer installed"
}

# Setup Neovim config
setup_nvim_config() {
    local nvim_config_dir="$HOME/.config/nvim"
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    # If running from the config directory itself, skip symlink
    if [ "$script_dir" = "$nvim_config_dir" ]; then
        log_info "Already in nvim config directory"
        return
    fi

    # Create config directory
    mkdir -p "$HOME/.config"

    if [ -d "$nvim_config_dir" ] || [ -L "$nvim_config_dir" ]; then
        log_warn "Nvim config already exists at $nvim_config_dir"
        return
    fi

    # Symlink config
    ln -s "$script_dir" "$nvim_config_dir"
    log_info "Linked $script_dir to $nvim_config_dir"
}

# Run Neovim setup commands
setup_neovim_plugins() {
    log_info "Installing Neovim plugins (this may take a minute)..."

    # PackerSync with timeout (gtimeout on macOS, timeout on Linux)
    local timeout_cmd="timeout"
    if [ "$PLATFORM" = "macos" ]; then
        if command -v gtimeout &> /dev/null; then
            timeout_cmd="gtimeout"
        else
            # Fallback: run without timeout on macOS if gtimeout not available
            timeout_cmd=""
        fi
    fi

    if [ -n "$timeout_cmd" ]; then
        $timeout_cmd 120 nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' 2>&1 || true
    else
        nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' 2>&1 &
        local pid=$!
        sleep 120 && kill $pid 2>/dev/null &
        wait $pid 2>/dev/null || true
    fi

    log_info "Neovim plugins installed"
}

# Install tree-sitter CLI (optional, for manual parser compilation)
install_treesitter_cli() {
    if command -v tree-sitter &> /dev/null; then
        log_info "tree-sitter CLI already installed"
        return
    fi

    if command -v npm &> /dev/null; then
        log_info "Installing tree-sitter CLI..."
        npm install -g tree-sitter-cli
        log_info "tree-sitter CLI installed"
    else
        log_warn "npm not found, skipping tree-sitter CLI"
    fi
}

# Add git aliases
setup_git_aliases() {
    log_info "Setting up git aliases..."

    local aliases=(
        "alias gci='git commit'"
        "alias gco='git checkout'"
        "alias gbr='git branch'"
        "alias gst='git status'"
        "alias gdf='git diff'"
        "alias gpl='git pull'"
        "alias gps='git push'"
    )

    for alias_cmd in "${aliases[@]}"; do
        local alias_name=$(echo "$alias_cmd" | cut -d'=' -f1 | sed 's/alias //')
        if ! grep -q "alias $alias_name=" "$SHELL_CONFIG" 2>/dev/null; then
            echo "$alias_cmd" >> "$SHELL_CONFIG"
        fi
    done

    log_info "Git aliases configured"
}

# Main installation
main() {
    log_info "Starting Neovim development environment setup..."

    detect_platform
    get_shell_config

    install_dependencies
    install_neovim
    install_nerd_font
    install_fzf
    install_ripgrep
    install_fd
    install_go
    install_golangci_lint
    install_nodejs
    install_packer
    setup_nvim_config
    install_treesitter_cli
    setup_neovim_plugins
    setup_git_aliases

    log_info "============================================"
    log_info "Setup complete!"
    log_info "============================================"
    log_info ""
    log_info "Please restart your terminal or run:"
    log_info "  source $SHELL_CONFIG"
    log_info ""
    log_info "Then start Neovim with: nvim"
}

main "$@"
