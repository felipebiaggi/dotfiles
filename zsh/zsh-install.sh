#!/bin/bash

set -e

apt-get -y install zsh

usermod -s /usr/bin/zsh $(whoami)
