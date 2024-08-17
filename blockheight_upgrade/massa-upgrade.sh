#!/bin/bash

# update and init app
export VERSION=2.4
URL="https://github.com/massalabs/massa/releases/download/MAIN.${VERSION}/massa_MAIN.${VERSION}_release_linux.tar.gz"
wget "${URL}" -O $HOME/massa_MAIN.${VERSION}_release_linux.tar.gz
tar -xvf $HOME/massa_MAIN.${VERSION}_release_linux.tar.gz -C $HOME/
chmod +x $HOME/massa/massa-node/massa-node $HOME/massa/massa-client/massa-client 
sudo systemctl restart massad && sudo journalctl -u massad -f -o cat

# start client
cd ~/massa/massa-client && ./massa-client -p "${PASSWORD}"
