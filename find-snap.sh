#!/bin/bash

OWallet=$(curl -s https://snapshot.owallet.io/files.json | jq -r '.files | max_by(.mtime) | .filename' | awk '{print "https://snapshot.owallet.io/orai/" $0}')
ORAICHAIN="https://orai.s3.us-east-2.amazonaws.com/$(curl -fsSL https://snapshot.orai.io/snapshot.json | jq -r '.[0].Key')"

SNAPSHOT=$(curl -fsSL "https://server-3.itrocket.net/mainnet/oraichain/" |
    grep -oE 'href="[^"]*oraichain_[^"]+"' |
    sed 's/^href="//; s/"$//' |
    sort -V |
    tail -n1)
ITRocket="$SNAPSHOT_BASE/$SNAPSHOT"

POLCACHU=$(curl -fsSL "https://www.polkachu.com/tendermint_snapshots/orai" |
    grep -oE 'https://snapshots\.polkachu\.com/snapshots/orai/orai_[0-9]+\.tar\.lz4' |
    sort -V |
    tail -n1)

urls=(
    "$ITRocket"
    "$ORAICHAIN"
    "$OWallet"
    "$POLCACHU"
    "https://snap.blockval.io/oraichain/oraichain_latest.tar.lz4"
)

# Iterate over each URL
for url in "${urls[@]}"; do
    echo "Download snapshots: $url" 
    if curl -s --head "$url" | head -n 1 | grep "200" > /dev/null; then
        if curl "$url" | lz4 -dc - | tar -xf - -C "${HOME}/.oraid"; then
            echo "Download and extraction successful from: $url"
            break
        else
            echo "Failed to extract archive from: $url"
        fi
    else
        echo "URL $url is not available."
    fi
done

