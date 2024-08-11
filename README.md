# utils

## Upgrade automatically
```
screen -S home -d -m bash -c "bash <(curl -s https://raw.githubusercontent.com/pulsar-node/utils/main/blockheight_upgrade.sh) -n oraichain -i Oraichain -t 29947556 -v v0.42.2 -b oraid"
```

## Upgrade manually
```
bash <(curl -s https://raw.githubusercontent.com/pulsar-node/utils/main/blockheight_upgrade/oraichain_upgrade.sh) v0.42.2 
```
