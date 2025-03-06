## Sahara Testnet Node Setup

This repo contains a minimal configuration for bootstraping a testnet node using docker compose.

## Get Started

### Install Docker

First, ensure Docker Engine is installed on your system. If you haven't installed Docker yet:

- For Ubuntu/Debian: [Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
- For MacOS: [Install Docker Desktop on Mac](https://docs.docker.com/desktop/install/mac-install/)
- For Windows: [Install Docker Desktop on Windows](https://docs.docker.com/desktop/install/windows-install/)

Follow the official installation guide for your operating system. Once installed, verify Docker is running with:

```bash
docker run hello-world
docker compose version
```

### Clone this repo

### Download the testnet data snapshot

Download the latest testnet data snapshot:

````bash
wget https://storage.googleapis.com/testnet-snapshots/data.bak.tar.gz

Extract the snapshot into `./chain-data/data` directory:

Note you need rename the extract directoy to `data`

### Start the node

```bash
docker compose up -d
````

### Check the logs

You can check the logs with:

```bash
docker compose logs -f | grep finaliz
```

The above command will continuously display log entries containing the word "finaliz", which indicates that the node is successfully running and synchronizing blocks from the network. This filtered view helps you confirm that your node is making progress without showing excessive log information.

## Node Configuration

The configuration files could be found in the `chain-data/config` directory.
Currently we have below ports exposed:

- 26656:26656 # CometBFT P2P port
- 26657:26657 # CometBFT RPC port
- 26660:26660 # CometBFT GRPC port
- 16161:16161 # ETH RPC port
- 16162:16162 # ETH Websocket RPC port

You can change the configuration in the `chain-data/config/config.toml` file.
