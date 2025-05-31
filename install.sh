#!/bin/bash

# Update package index
sudo apt update

# Install Neovim
if ! command -v nvim &> /dev/null
then
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
    sudo rm -rf /opt/nvim
    sudo tar -C /opt -xzf nvim-linux64.tar.gz
    rm nvim-linux64.tar.gz
    echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' >> ~/.bashrc
    export PATH="$PATH:/opt/nvim-linux64/bin"
fi

# Install packer
if [ ! -d ~/.local/share/nvim/site/pack/packer ]; then
    git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
fi

# Install golang
if ! command -v go &> /dev/null
then
    curl -LO https://go.dev/dl/go1.22.2.linux-amd64.tar.gz
    sudo rm -rf /usr/local/go 
    sudo tar -C /usr/local -xzf go1.22.2.linux-amd64.tar.gz 
    rm go1.22.2.linux-amd64.tar.gz
    echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
    export PATH=$PATH:/usr/local/go/bin
    go version
fi

# Install golangci-lint
echo "Installing golangci-lint..."
if ! command -v golangci-lint &> /dev/null; then
    # Ensure GOPATH/bin exists
    mkdir -p "$(go env GOPATH)/bin"
    curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b "$(go env GOPATH)/bin"
    echo "golangci-lint installed successfully"
else
    echo "golangci-lint already installed"
fi

# Install nvm and Node.js
if [ ! -d ~/.nvm ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    # Use Node.js 16 with nvm
    nvm install 16
    nvm use 16
fi

# Install ripgrep
if ! command -v rg &> /dev/null
then
    sudo apt-get install -y ripgrep
fi

# Source bashrc to get new PATH
source ~/.bashrc

# Run PackerSync in Neovim
nvim --headless -c "PackerSync" -c "qa"

# Run LspStart in Neovim
nvim --headless -c "LspStart" -c "qa"

# Run GoInstallBinaries
nvim --headless -c "GoInstallBinaries" -c "qa"

# Create aliases for git (only if they don't exist)
if ! grep -q "alias gci=" ~/.bashrc; then
    echo "alias gci='git commit'" >> ~/.bashrc
fi
if ! grep -q "alias gco=" ~/.bashrc; then
    echo "alias gco='git checkout'" >> ~/.bashrc
fi
if ! grep -q "alias gbr=" ~/.bashrc; then
    echo "alias gbr='git branch'" >> ~/.bashrc
fi

# Apply changes in current shell
source ~/.bashrc

echo "Setup complete."
