#!/bin/bash

set -e

### Set zsh with default shell ###
chsh -s $(which zsh)

### Copy zsh config ###
cd -d .zshrc ~/

### Install oh-my-zsh ###
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh

### Theme ###
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

### Autosuggestions ###
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

### Syntax Highlighting ###
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim
