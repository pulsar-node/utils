
# utils

## Upgrade oraichain automatically (../wasmd)
```
screen -dmS home bash -c "bash <(curl -s https://raw.githubusercontent.com/pulsar-node/utils/main/blockheight_upgrade.sh) \
-n wasmd -i Oraichain -b oraid -t 59442845 -v v0.50.11"
```


## Upgrade oraichain manual (../wasmd)
```
bash <(curl -s https://raw.githubusercontent.com/pulsar-node/utils/main/blockheight_upgrade/oraid_upgrade.sh) v0.50.11
```
