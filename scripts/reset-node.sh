#!/bin/bash

# Check if the docker command exists
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed."
    exit 1
fi

echo "Docker is installed."

check_disk_size() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        disk_size=$(df --block-size=GB . | awk 'NR==2 {print $2}' | sed 's/GB//')
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        disk_size=$(df -g . | awk 'NR==2 {print $2}')
    else
        echo "Unsupported OS."
        exit 1
    fi

    if [ "$disk_size" -lt 800 ]; then
        echo "Disk size is less than or equal to 800GB. Please deploy this node on a larger disk"
        exit 1
    fi
}

check_disk_size


# Check for the existence of the node_key.json file
node_key_file="chain-data/config/node_key.json"

if [ -f "$node_key_file" ]; then
    echo "File $node_key_file exists."
    read -p "Do you want to delete this file? (y/N): " delete_confirm
    if [[ "$delete_confirm" == "y" || "$delete_confirm" == "Y" ]]; then
        echo "deleting $node_key_file"
        rm "$node_key_file"
    fi
fi

# Check for the existence of the node_key.json file
validator_key_file="chain-data/config/priv_validator_key.json"

if [ -f "$validator_key_file" ]; then
    echo "File $validator_key_file exists."
    read -p "Do you want to delete this file? (y/N): " delete_confirm
    if [[ "$delete_confirm" == "y" || "$delete_confirm" == "Y" ]]; then
        echo "deleting $validator_key_file"
        rm "$validator_key_file"
    fi
fi

mkdir -p chain-data/data/
echo "{}" > chain-data/data/priv_validator_state.json
echo "You're all set! you can run sahara testnet node using: docker compose up -d "

