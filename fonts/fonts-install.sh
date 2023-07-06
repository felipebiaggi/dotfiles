#!/bin/bash

set -e
  
git clone --filter=blob:none --sparse https://github.com/ryanoasis/nerd-fonts.git

cd nerd-fonts

git sparse-checkout add patched-fonts/JetBrainsMono

./install.sh
