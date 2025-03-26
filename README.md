
# utils

## Upgrade Oraichain automatically (~/wasmd)
```
screen -dmS home bash -c "bash <(curl -s https://raw.githubusercontent.com/pulsar-node/utils/main/blockheight_upgrade.sh) \
  -n wasmd -i Oraichain -t 55384278 -v v0.50.9 -b oraid"
```


## Manulae Upgrade
```
bash <(curl -s https://raw.githubusercontent.com/pulsar-node/utils/main/blockheight_upgrade/wasmd_upgrade.sh) v0.50.9
```
