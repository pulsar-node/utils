#!/bin/bash

sudo systemctl stop oraid

# Download new binary
cd $HOME 
rm -rf orai 
git clone https://github.com/oraichain/orai 
cd orai
git checkout $1   # version v0.xx.x
cd orai
make install
oraid version
sudo systemctl start oraid
