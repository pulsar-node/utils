#!/bin/bash

sudo systemctl stop oraid

VERSION=$1
# Download new binary
cd $HOME 
rm -rf orai 
git clone https://github.com/oraichain/orai 
cd orai/orai 
git checkout $VERSION
# make install
echo $1 "<--" $VERSION "<--"
sudo systemctl start oraid
