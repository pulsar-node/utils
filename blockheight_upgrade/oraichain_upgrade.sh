#!/bin/bash

sudo systemctl stop oraid

# Download new binary
cd $HOME 
rm -rf orai 
git clone https://github.com/oraichain/orai 
cd orai/orai 
git checkout v0.42.1
make install

sudo systemctl start oraid

