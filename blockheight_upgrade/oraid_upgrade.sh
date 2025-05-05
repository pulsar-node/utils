#!/bin/bash

sudo systemctl stop oraid
cd $HOME/wasmd
git pull
git checkout $1   # version v0.50.xx
make build
oraid version --long | grep -e commit -e version
sudo systemctl restart oraid
