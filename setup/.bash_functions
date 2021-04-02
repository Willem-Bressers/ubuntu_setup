#!/bin/bash

mkproj() {
	mkdir ~/projects/"$1"
	cd ~/projects/"$1"
	mkvirtualenv --system-site-packages "$1"
}

jup() {
	jupyter lab --port=8889 --ip=0.0.0.0 
}