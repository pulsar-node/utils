#!/bin/bash

sudo systemctl stop oraid

# Download new binary
cd $HOME 
rm -rf orai 
git clone https://github.com/oraichain/orai 
cd orai/orai
VERSION=$1
git checkout $VERSION
# make install

sudo systemctl start oraid
