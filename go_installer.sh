#!/bin/bash

# Parse command-line options
while getopts ":v:" flag; do
  case "${flag}" in
    v) V="go${OPTARG}" ;;
    *) echo "WARN: unknown parameter: ${OPTARG}" ;;
  esac
done

# Determine the Go version
LATEST_VERSION=$(curl -s https://go.dev/dl/?mode=json | jq -r '.[0].version')
VERSION="${V:-$LATEST_VERSION}"

# Determine the operating system and architecture
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)
case "${ARCH}" in
  x86_64) ARCH="amd64" ;;
  aarch64) ARCH="arm64" ;;
  *) echo "Unsupported architecture: ${ARCH}" >&2; exit 1 ;;
esac

# Download and install Go binaries
curl -L -# -O "https://golang.org/dl/${VERSION}.${OS}-${ARCH}.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "${VERSION}.${OS}-${ARCH}.tar.gz"
rm "${VERSION}.${OS}-${ARCH}.tar.gz"

# Update PATH and GOPATH
if ! grep -q "/usr/local/go/bin" "$HOME/.bash_profile"; then
  echo "export PATH=\$PATH:/usr/local/go/bin:~/go/bin" >> "$HOME/.bash_profile"
fi
if ! grep -q "GOPATH=\$HOME/go" "$HOME/.bash_profile"; then
  echo "export GOPATH=\$HOME/go" >> "$HOME/.bash_profile"
fi

# Ensure .bash_profile exists
[ ! -f ~/.bash_profile ] && touch ~/.bash_profile
[ ! -d ~/go/bin ] && mkdir -p ~/go/bin

# Source .bash_profile to apply changes
source "$HOME/.bash_profile"

# Display Go version
go version
