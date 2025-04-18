#!/bin/bash

DATA_DIR=./chain-data
SNAPSHOT=./2600000.tar.gz
SNAPSHOT_HEIGHT=2600000

# check whether $DATA_DIR/data exists, if so backup it to $DATA_DIR/data.bak
if [ -d "$DATA_DIR/data" ]; then
    echo "Backing up $DATA_DIR/data to $DATA_DIR/data.bak"
    mv $DATA_DIR/data $DATA_DIR/data.bak
fi

mkdir $DATA_DIR/data
echo "{}" > $DATA_DIR/data/priv_validator_state.json


# loading snapshot
./saharad --home $DATA_DIR snapshots load $SNAPSHOT

# recover app state

./saharad --home chain-data/ snapshots restore $SNAPSHOT_HEIGHT 3
"reseting comet state"
./saharad --home chain-data/ comet bootstrap-state  --height $SNAPSHOT_HEIGHT

echo "Successfully recover the chain state!"