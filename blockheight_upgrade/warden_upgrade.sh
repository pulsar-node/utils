sudo systemctl stop wardend

# Download new binary
cd $HOME
rm -rf wardenprotocol
git clone --depth 1 --branch v0.2.0 https://github.com/warden-protocol/wardenprotocol/
cd  wardenprotocol/warden/cmd/wardend
go build
sudo mv wardend /root/go/bin/

sudo systemctl start wardend
