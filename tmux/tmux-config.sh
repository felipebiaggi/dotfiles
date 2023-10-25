#!/bin/bash
set -e

### Plugin Manager ###
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

### Move Config File ###

cp .tmux.conf ~/