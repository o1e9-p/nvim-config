#!/bin/bash

# Update package index
sudo apt update

# Install Neovim
if ! command -v nvim  &> /dev/null
then
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
rm nvim-linux64.tar.gz
export PATH="$PATH:/opt/nvim-linux64/bin"
fi

# Install packer
if [ ! -d "~/.local/share/nvim/site/pack/packer" ]; then
git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
fi

# Install golang
curl -LO https://go.dev/dl/go1.22.2.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.22.2.linux-amd64.tar.gz 
export PATH=$PATH:/usr/local/go/bin
go version
rm go1.22.2.linux-amd64.tar.gz
go version

# Install golangci-lint
curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.57.2

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Use Node.js 16 with nvm
nvm install 16
nvm use 16

# Install riggrep
sudo apt-get install ripgrep

# Run PackerSync in Neovim
nvim -c "PackerSync" -c "qa"

# Run LspStart in Neovim
nvim -c "LspStart" -c "qa"

# Run GoInstallBinaries
nvim -c "GoInstallBinaries" -c "qa"

# Create aliases for git
echo "alias gci='git commit'" >> ~/.bashrc
echo "alias gco='git checkout'" >> ~/.bashrc
echo "alias gbr='git branch'" >> ~/.bashrc

# Apply changes in current shell
source ~/.bashrc

echo "Setup complete."
