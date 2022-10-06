# sui_intro_workshop

Intro to Sui Object Workshop Repo

## Installing Sui Binaries

- Install Rust and other dependencies: https://docs.sui.io/build/install#prerequisites
- git clone https://github.com/MystenLabs/sui.git --branch devnet
- git fetch upstream
- git checkout devnet-0.10.0
- cargo install --locked --git https://github.com/MystenLabs/sui.git --branch "devnet" sui sui-gateway
- sui client (use default options to connect to devnet)

## Acquire Devnet Sui Tokens

- Join Sui Discord: https://discord.com/invite/GcFNX4WMrB
- Get your current wallet address with the command: sui client active-address
- Go to #devnet-faucet channel and type "!faucet [your wallet address]"

## Build and Publish the Module

- sui move build
- sui client publish --path [local file path to the sui intro workshop module] --gas-budget 30000