# utils

## Upgrade automatically
```
screen -dmS home bash -c "bash <(curl -s https://raw.githubusercontent.com/pulsar-node/utils/main/blockheight_upgrade.sh) -n oraichain -i Oraichain -t 34717352 -v v0.42.4 -b oraid"
screen -ls
```

## Upgrade manually
```
bash <(curl -s https://raw.githubusercontent.com/pulsar-node/utils/main/blockheight_upgrade/oraichain_upgrade.sh) v0.42.4 
```
