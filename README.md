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

- git clone https://github.com/hyd628/sui_intro_workshop.git
- sui move build
- sui client publish --path [local file path to the sui intro workshop module] --gas-budget 30000

## Breakout Session Instructions

Set up the environment and git clone this repo per the instructions in this README. 

Familiarize yourself with the sui_dinos.move contract. You will use that as the starting point for the following two tasks. 

### Challenge One

Create a new method in the `sui_intro_workshop::dino_nft` module for the owner of the NFT contract to withdraw the balance collected in `MintingTreasury` to their own account.

Hints: 

- The contract already has most of the infrastructure needed to do this. What are we using to mark the owner or minter account of the NFT contract?
- Tou may need to use functions from [the coin module](https://github.com/MystenLabs/sui/blob/fe1db4b50425c28693a34564bd8b54be8a68ad89/crates/sui-framework/docs/coin.md) and [the balance module]
(https://github.com/MystenLabs/sui/blob/fe1db4b50425c28693a34564bd8b54be8a68ad89/crates/sui-framework/docs/balance.md
)

### Challenge Two

Currently, each dino NFT object can only have one child NFT object (try to mint a new dino NFT object to a dino NFT that already has a child  and see what error you get). 

Make the changes necessary to the dino_nft module to allow each parent Dino NFT to own many child NFTs. 

Hint: You will need to utilize the [vector data structure](https://move-book.com/advanced-topics/managing-collections-with-vectors.html).

### Resources

[Sui Developer Documentation](https://docs.sui.io/)
[Move Programming Language Book](https://move-book.com/index.html)
[Sui by Example](https://examples.sui.io/index.html)

### Check Solutions

When you are ready to see the solutions:

- Here is the solution to challenge one
- Here is the solution to challenge two

