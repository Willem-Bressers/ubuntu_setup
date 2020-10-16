#!/bin/bash

mkproj() {
	mkdir ~/projects/"$1"
	cd ~/projects/"$1"
	mkvirtualenv --system-site-packages "$1"
}