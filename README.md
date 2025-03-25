## 🚀 Sahara Testnet Node Setup

This repo contains a minimal configuration for bootstraping a testnet node using docker compose.

## 🏁 Get Started

### 🐳 Install Docker

First, ensure Docker Engine is installed on your system. If you haven't installed Docker yet:

- For Ubuntu/Debian: [Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
- For MacOS: [Install Docker Desktop on Mac](https://docs.docker.com/desktop/install/mac-install/)
- For Windows: [Install Docker Desktop on Windows](https://docs.docker.com/desktop/install/windows-install/)

Follow the official installation guide for your operating system. Once installed, verify Docker is running with:

```bash
docker run hello-world
docker compose version
```

### 📥 Clone this repo

## ⚙️ Node Configuration

The configuration files could be found in the `chain-data/config` directory.
Currently we have below ports exposed:

- 26656:26656 # CometBFT P2P port
- 26657:26657 # CometBFT RPC port
- 16161:16161 # ETH RPC port
- 16162:16162 # ETH Websocket RPC port

You can change the configuration in the `chain-data/config/config.toml` file.

### Configure State sync

State sync is a feature that allows your node to synchronize the state of the chain from a trusted source instead of downloading the entire history from the genesis block. This significantly reduces the synchronization time by fetching only the latest state snapshot rather than processing all historical blocks.

The state sync configuration is already set up in the `chain-data/config/config.toml` file with appropriate RPC servers, trusted height, and hash values. You can verify these settings in the configuration file.

The Sahara testnet creates a new state snapshot every 1000 blocks. For optimal synchronization, you can update the state sync configuration to use the latest snapshot by modifying the following parameters in the `chain-data/config/config.toml` file:

```bash
sed -i 's/trust_height = 0/trust_height = {block height/g' chain-data/config/config.toml
sed -i 's/trust_hash = ""/trust_hash = "{hash at the trust height}"/g' chain-data/config/config.toml
```

You can get th latest block hash at the specified height using this command:

```bash
 curl https://testnet-cos-rpc1.saharalabs.ai/commit?height={height} | jq '.result.signed_header.commit.block_id.hash'
```

### Update the node information

#### Moniker

Moniker is the name of your node. You can change it by editing the `moniker` field in the `config.toml` file.

```bash
sed -i 's/moniker = "sahara-testnet-node1"/moniker = "your-node-name"/g' chain-data/config/config.toml
```

#### External Address

External address is the address of your node that will be used to connect to the network. You can change it by editing the `external_address` field in the `config.toml` file. Please make sure to use the correct IP/port combination.

```bash
sed -i 's/external_address = ""/external_address = "your-node-address"/g' chain-data/config/config.toml
```

### Run the node

```bash
docker compose up -d
```

### Enable VersionDB
This setup enables VersionDB, a high-performance state storage solution that significantly improves node performance. VersionDB will be automatically enabled during the first node restart after state sync has completed.

Important: RPC queries will only be available for blocks processed after VersionDB is enabled. Historical blocks prior to VersionDB activation will not be queryable through the RPC interface.

To enable VersionDB, you need to restart the node after state sync has completed.


### 📋 Check the logs

You can check the logs with:

```bash
docker compose logs -f | grep finaliz
```

The above command will continuously display log entries containing the word "finaliz", which indicates that the node is successfully running and synchronizing blocks from the network. This filtered view helps you confirm that your node is making progress without showing excessive log information.
