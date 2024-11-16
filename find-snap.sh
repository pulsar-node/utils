#!/bin/bash

# SNAP_NAME=$(curl -s https://ss.pryzm.nodestake.org/ | egrep -o ">20.*\.tar.lz4" | tr -d ">")
# curl -o - -L https://ss.pryzm.nodestake.org/${SNAP_NAME}  | lz4 -c -d - | tar -x -C $HOME/.pryzm

# List of URLs to check 
owallet=$(curl -s https://snapshot.owallet.io/files.json | jq -r '.files | max_by(.mtime) | .filename' | awk '{print "https://snapshot.owallet.io/orai/" $0}')
polkachu=$(curl -s https://www.polkachu.com/tendermint_snapshots/orai | grep -oE 'https://[^"]+orai_[0-9]+\.tar\.lz4' | sort | uniq | head -n 1)

urls=(
    "$owallet"
    "$polkachu"
    "https://files.andromedanode.co/$PROJECT/snap_$PROJECT.tar.lz4"    
    )

# Iterate over each URL
for url in "${urls[@]}"; do
    if curl -s --head "$url" | head -n 1 | grep "200" > /dev/null; then
        # If the URL returns status 200, download and extract the archive
        if curl "$url" | lz4 -dc - | tar -xf - -C "$DIRECTORY"; then
            echo "Download and extraction successful from: $url"
            # Exit loop since download was successful
            break
        else
            echo "Failed to extract archive from: $url"
        fi
    else
        echo "URL $url is not available."
    fi
done

