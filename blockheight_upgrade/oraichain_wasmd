
sudo systemctl stop oraid

cd $HOME 
git clone https://github.com/oraichain/wasmd
cd wasmd
git checkout v0.50.0
# NOTE: you may need to upgrade your Golang version to 1.22.6+ with GOTOOLCHAIN to build the binary
make build
oraid version

sudo systemctl restart oraid
