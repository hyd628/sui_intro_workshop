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

Set up the environment, git clone this repo, and acquire some DevNet Sui tokens per the instructions in this README. 

Familiarize yourself with the sui_dinos.move contract. You will use that as the starting point for the following two tasks. 

### Challenge One: Working with Sui Coin Objects

Currently, we are aborting the transaction if the coin object sent in during paid minting is not the exact same amount as the minting fee. 

Make the changes necessary so that we check if the coin object sent in is enough to cover the minting fee and send back any extra left as change, instead of only accepting the exact amount. 

Hint: 
- You will need to utilize functions in [the sui::coin module](https://github.com/MystenLabs/sui/blob/fe1db4b50425c28693a34564bd8b54be8a68ad89/crates/sui-framework/docs/coin.md).
- It might be useful to redefine the existing error type for not sending in the exact amount. 

### Challenge Two: Access Based Withdrawal

Create a new method in the `sui_intro_workshop::dino_nft` module for the owner of the NFT contract to withdraw the balance collected in `MintingTreasury` to their own account.

Hints: 

- The contract already has most of the infrastructure needed to do this. What are we using to mark the owner or minter account of the NFT contract?
- You will need to use functions from [the sui::coin module](https://github.com/MystenLabs/sui/blob/fe1db4b50425c28693a34564bd8b54be8a68ad89/crates/sui-framework/docs/coin.md) and [the sui::balance module](https://github.com/MystenLabs/sui/blob/fe1db4b50425c28693a34564bd8b54be8a68ad89/crates/sui-framework/docs/balance.md).
- It might make sense to create a new error type for an edge case here.

### Resources

- [Sui Framework Docs](https://github.com/MystenLabs/sui/tree/fe1db4b50425c28693a34564bd8b54be8a68ad89/crates/sui-framework/docs)
- [Sui Developer Documentation](https://docs.sui.io/)
- [Move Programming Language Book](https://move-book.com/index.html)
- [Sui by Example](https://examples.sui.io/index.html)

### Check Solutions

When you are ready to see the solutions:

- [Solution to challenge one](https://github.com/hyd628/sui_intro_workshop/blob/main/breakout_session_solutions/challenge_1_solution.move)
- [Solution to challenge two](https://github.com/hyd628/sui_intro_workshop/blob/main/breakout_session_solutions/challenge_2_solution.move)
- [Combined solution to both challenges](https://github.com/hyd628/sui_intro_workshop/blob/main/breakout_session_solutions/combined_solution.move)

