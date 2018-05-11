#!/usr/bin/env bash

if [ ! -f ~/.bash_aliases ]; then
	touch ~/.bash_aliases
fi

if [ ! -f ~/.bash_profile ]; then
	touch ~/.bash_profile
fi

if [ ! -f ~/.pam_environment ]; then
	touch ~/.pam_environment
fi

