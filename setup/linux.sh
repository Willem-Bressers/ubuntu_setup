#!/bin/bash

# get absolute location of this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# copy custom aliases
cp $DIR/.bash_aliases $HOME/.bash_aliases

# copy custom functions
cp $DIR/.bash_functions $HOME/.bash_functions

echo -e "\n# source bash functions" >> $HOME/.bashrc
echo -e '\nif [ -f ~/.bash_functions ]; then\n\t. ~/.bash_functions\nfi' >> $HOME/.bashrc

# ensure bash is sourced (with new addtions)
echo -e "\e[31mRun\e[0m source ~/.bashrc"