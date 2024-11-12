# utils

## Upgrade automatically
```
screen -dmS home bash -c "bash <(curl -s https://raw.githubusercontent.com/pulsar-node/utils/main/blockheight_upgrade.sh) -n oraichain -i Oraichain -t 39000564 -v v0.50.0 -b oraid"
screen -r home
```

## Upgrade manually
```
bash <(curl -s https://raw.githubusercontent.com/pulsar-node/utils/main/blockheight_upgrade/oraichain_upgrade.sh) v0.50.0 
```
