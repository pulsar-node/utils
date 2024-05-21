#!/bin/bash

# List of URLs to check
urls=(
    "https://files.andromedanode.co/$PROJECT/snap_$PROJECT.tar.lz4"
    "https://$NETWORK-files.itrocket.net/$PROJECT/snap_$PROJECT.tar.lz4"
    "https://snapshots-$NETWORK.nodejumper.io/$PROJECT-$NETWORK/$PROJECT-$PROJECT_latest.tar.lz4"
    "https://snap.nodex.one/$PROJECT-$NETWORK/$PROJECT-latest.tar.lz4"
    "https://snapshots.kjnodes.com/$PROJECT-$NETWORK/snapshot_latest.tar.lz4"
    # Add more URLs here if needed
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
