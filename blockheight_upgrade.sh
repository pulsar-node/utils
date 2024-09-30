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

echo -e "Your $(printCyan ${CHAIN_NAME}) node-name $(printCyan ${HOSTNAME}) will be upgraded to version $(printCyan ${VERSION})"
echo -e " ... on block height: $(printRed ${TARGET_BLOCK})"

while sleep 5; do
  if [ -z "$PORT_RPC" ]; then
    height=$($BINARY status 2>&1 | jq -r '.SyncInfo.latest_block_height // .sync_info.latest_block_height')
  else
    height=$($BINARY status --node="tcp://127.0.0.1:$PORT_RPC" 2>&1 | jq -r '.SyncInfo.latest_block_height // .sync_info.latest_block_height')
  fi
  if ((height >= TARGET_BLOCK)); then
    bash <(curl -s https://raw.githubusercontent.com/pulsar-node/utils/main/blockheight_upgrade/${CHAIN_NAME}_upgrade.sh) $VERSION
    echo -e "Your node was successfully upgraded to version: $(printCyan ${VERSION})"
    $BINARY version
    break
  else
    rest=$(expr $TARGET_BLOCK - $height)
    h=$(($rest / 4500))
    m=$(($rest % 4500 / 60))
    s=$(($rest % 4500 % 60))
    printf "Current block height: %s - %s %02d:%02d:%02d   \r" $(printYellow ${height}) "$rest" "$h" "$m" "$s"
  fi
done

printLine
echo -e "Check logs:            $(printYellow "sudo journalctl -u ${BINARY} -f -o cat")"
echo -e "Check synchronization: $(printYellow "${BINARY} status 2>&1 | jq -r '.SyncInfo.latest_block_height // .sync_info.latest_block_height'")"
sleep 2
