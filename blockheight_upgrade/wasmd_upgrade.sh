#!/bin/bash

sudo systemctl stop oraid

cd $HOME 
rm -rf wasmd 
git clone https://github.com/oraichain/wasmd
cd wasmd
git checkout $1  #v0.xx.x
# NOTE: you may need to upgrade your Golang version to 1.22.6+ with GOTOOLCHAIN to build the binary
make build
oraid version

sudo systemctl restart oraid
