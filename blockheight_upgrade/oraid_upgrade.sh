#!/bin/bash

sudo systemctl stop oraid

# Download new binary
cd $HOME 
rm -rf orai 
git clone https://github.com/oraichain/orai 
cd orai
git checkout $1   # version v0.xx.x
cd orai
# NOTE: you may need to upgrade your Golang version to 1.22.6+ with GOTOOLCHAIN to build the binary
make install
oraid version
sudo systemctl start oraid
