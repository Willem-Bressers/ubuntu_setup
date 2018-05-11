#!/usr/bin/env bash

sudo apt install -y vim
echo "EDITOR=$(which vim)" >> ~/.pam_environment

