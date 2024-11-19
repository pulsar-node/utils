#!/bin/bash

sudo systemctl stop oraid

cd $HOME 
git clone https://github.com/oraichain/wasmd
cd wasmd
git checkout $1  #v0.xx.x
make build
oraid version

sudo systemctl restart oraid
