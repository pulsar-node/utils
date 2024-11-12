#!/bin/bash

source <(curl -s https://raw.githubusercontent.com/pulsar-node/utils/main/colorpath.sh)

while getopts n:i:t:v:b:c:p: flag; do
  case "${flag}" in
    n) CHAIN_NAME=$OPTARG ;;
    i) CHAIN_ID=$OPTARG ;;
    t) TARGET_BLOCK=$OPTARG ;;
    v) VERSION=$OPTARG ;;
    b) BINARY=$OPTARG ;;
    c) CHEAT_SHEET=$OPTARG ;;
    p) PORT_RPC=$OPTARG ;;
    *) echo "WARN: unknown parameter: ${OPTARG}"
  esac
done

printLogo

echo -e "Your ${CHAIN_NAME} node-name: $(printCyan ${HOSTNAME}) will be upgraded to version $(printCyan ${VERSION})"
echo -e "...  on block height: $(printCyan ${TARGET_BLOCK})"

while sleep 5; do
  if [ -z "$PORT_RPC" ]; then
    height=$($BINARY status 2>&1 | jq -r '.SyncInfo.latest_block_height // .sync_info.latest_block_height')
  else
    height=$($BINARY status --node="tcp://127.0.0.1:$PORT_RPC" 2>&1 | jq -r '.SyncInfo.latest_block_height // .sync_info.latest_block_height')
  fi

  # Check if height are valid numbers
  if ! [[ "$height" =~ ^[0-9]+$ ]]; then
    printf "Error: Invalid block height values.\r"
    continue
  fi
  
  if ((height >= TARGET_BLOCK)); then
    bash <(curl -s https://raw.githubusercontent.com/pulsar-node/utils/main/blockheight_upgrade/${CHAIN_NAME}_upgrade.sh) $VERSION
    echo -e "Your node was successfully upgraded to version: $(printCyan ${VERSION})"
    $BINARY version
    break
  else
    rest=$(expr $TARGET_BLOCK - $height)
    ms=$(($rest * 82 / 100))
    h=$(($ms / 3600))
    m=$(($ms % 3600 / 60))
    s=$(($ms % 3600 % 60))
    printf "Current block height: %s - %s %02d:%02d:%02d   \r" $(printYellow ${height}) $(printGreen ${rest}) "$h" "$m" "$s"
  fi
done

printLine
sleep 5
