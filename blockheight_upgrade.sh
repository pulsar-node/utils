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

echo -e "Your ${CYAN}$CHAIN_NAME${NC} node will be upgraded to version ${CYAN}$VERSION${NC} ..."
echo -e "...  on block height: ${CYAN}$TARGET_BLOCK${NC}"

for (( ; ; )); do
  if [ -z "$PORT_RPC" ]; then
    height=$($BINARY status 2>&1 | jq -r '.SyncInfo.latest_block_height // .sync_info.latest_block_height')
  else
    height=$($BINARY status --node="tcp://127.0.0.1:$PORT_RPC" 2>&1 | jq -r '.SyncInfo.latest_block_height // .sync_info.latest_block_height')
  fi
  if ((height >= TARGET_BLOCK)); then
    bash <(curl -s https://raw.githubusercontent.com/pulsar-node/utils/main/blockheight_upgrade/${CHAIN_NAME}_upgrade.sh) $VERSION
    printCyan "Your node was successfully upgraded to version: $VERSION" && sleep 2
    $BINARY version --long | head
    break
  else
    printf "Current block height: %s%s\r" "${YELLOW}${height}${NC} - " $(expr $height - $TARGET_BLOCK)
  fi
  sleep 5
done

printLine
echo -e ""
echo -e "Check logs:            ${CYAN}sudo journalctl -u $BINARY_NAME -f --no-hostname -o cat ${NC}"
echo -e "Check synchronization: ${CYAN}$BINARY_NAME status 2>&1 | jq -r '.SyncInfo.latest_block_height // .sync_info.latest_block_height'${NC}"
echo -e "More commands:         ${CYAN}$CHEAT_SHEET${NC}"
