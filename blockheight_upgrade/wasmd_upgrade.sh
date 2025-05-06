#!/bin/bash

sudo systemctl stop oraid
cd $HOME
cp $HOME/go/bin/oraid $HOME/go/bin/oraid.bak
rm -rf wasmd 
git clone https://github.com/oraichain/wasmd
cd wasmd
git checkout $1  #v0.50.xx
make build
oraid version
sudo systemctl restart oraid
