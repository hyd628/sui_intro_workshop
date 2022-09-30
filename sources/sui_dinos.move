// Copyright (c) 2022, Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0

/// A basic NFT example to demonstrate how to create and interact with a Dino NFT
/// on Sui that can own and a child Dino NFT, illustrating basic parent-child object 
/// relationships in Sui Move. 
/// 
/// Based on https://github.com/MystenLabs/sui/blob/94e5bca0f38def733d2a3bb45683834126069c43/crates/sui-framework/sources/devnet_nft.move
/// 
module sui_intro_workshop::dino_nft {
    use sui::url::{Self, Url};
    use std::string;
    use std::option::{Self, Option};
    use sui::object::{Self, ID, UID};
    use sui::event;
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    /// An example NFT that can be minted by anybody
    struct DinoNFT has key, store {
        id: UID,
        /// Name for the token
        name: string::String,
        /// Description of the token
        description: string::String,
        /// URL for the token
        url: Url,
        /// Dino egg optional field
        dino_egg: Option<ID>,
    }

    struct MintNFTEvent has copy, drop {
        // The Object ID of the NFT
        object_id: ID,
        // The creator of the NFT
        creator: address,
        // The name of the NFT
        name: string::String,
    }

    /// Private function that creates and returns a new DinoNFT
    fun mint(
        name: vector<u8>,
        description: vector<u8>,
        url: vector<u8>,
        ctx: &mut TxContext
    ): DinoNFT {
        let nft = DinoNFT {
            id: object::new(ctx),
            name: string::utf8(name),
            description: string::utf8(description),
            url: url::new_unsafe_from_bytes(url),
            // Set the dino_egg field to None
            dino_egg: option::none()
        };
        let sender = tx_context::sender(ctx);
        event::emit(MintNFTEvent {
            object_id: object::uid_to_inner(&nft.id),
            creator: sender,
            name: nft.name,
        });
        nft
    }

    /// Mint a DinoNFT to an account 
    public entry fun mint_to_account(
        name: vector<u8>,
        description: vector<u8>,
        url: vector<u8>,
        ctx: &mut TxContext
    ) {
        let nft = mint(name, description, url, ctx);
        transfer::transfer(nft, tx_context::sender(ctx));
    }

    /// Mint a DinoNFT and set it as a child to a parent object
    public entry fun mint_to_object(
        name: vector<u8>,
        description: vector<u8>,
        url: vector<u8>,
        dino_parent: &mut DinoNFT,
        ctx: &mut TxContext
    ) {
        let nft = mint(name, description, url, ctx);
        option::fill(&mut dino_parent.dino_egg, object::id(&nft));
        transfer::transfer_to_object(nft, dino_parent);
    }

    /// Update the `description` of `nft` to `new_description`
    public entry fun update_description(
        nft: &mut DinoNFT,
        new_description: vector<u8>,
        _: &mut TxContext
    ) {
        nft.description = string::utf8(new_description)
    }

    /// Hatch the egg by changing the NFT's description, name and URL
    public entry fun hatch_egg(
        name: vector<u8>,
        description: vector<u8>,
        url: vector<u8>,
        egg_nft: &mut DinoNFT,
        _parent_nft: &mut DinoNFT,
        _: &mut TxContext
    ) {
        egg_nft.name = string::utf8(name);
        egg_nft.description = string::utf8(description);
        egg_nft.url = url::new_unsafe_from_bytes(url)
    }

    /// Retrieve the child NFT and send it to the message sender
    public entry fun retrieve_child_dino(
        child_nft: DinoNFT,
        parent_nft: &mut DinoNFT,
        ctx: &mut TxContext
    ) {
        option::extract(&mut parent_nft.dino_egg);
        transfer::transfer(child_nft, tx_context::sender(ctx));
    }

    /// Permanently delete `nft`
    public entry fun burn(nft: DinoNFT, _: &mut TxContext) {
        let DinoNFT { id, name: _, description: _, url: _, dino_egg: _} = nft;
        object::delete(id)
    }

    /// Get the NFT's `name`
    public fun name(nft: &DinoNFT): &string::String {
        &nft.name
    }

    /// Get the NFT's `description`
    public fun description(nft: &DinoNFT): &string::String {
        &nft.description    
    }

    /// Get the NFT's `url`
    public fun url(nft: &DinoNFT): &Url {
        &nft.url
    }
}

#[test_only]
module sui_intro_workshop::dino_nftTests {
    use sui_intro_workshop::dino_nft::{Self, DinoNFT};
    use sui::test_scenario;
    use sui::transfer;
    use std::string;

    #[test]
    fun mint_transfer_update() {
        let addr1 = @0xA;
        let addr2 = @0xB;
        // create the NFT
        let scenario = test_scenario::begin(&addr1);
        {
            dino_nft::mint_to_account(b"test", b"a test", b"https://www.sui.io", test_scenario::ctx(&mut scenario))
        };
        // send it from A to B
        test_scenario::next_tx(&mut scenario, &addr1);
        {
            let nft = test_scenario::take_owned<DinoNFT>(&mut scenario);
            transfer::transfer(nft, addr2);
        };
        // update its description
        test_scenario::next_tx(&mut scenario, &addr2);
        {
            let nft = test_scenario::take_owned<DinoNFT>(&mut scenario);
            dino_nft::update_description(&mut nft, b"a new description", test_scenario::ctx(&mut scenario)) ;
            assert!(*string::bytes(dino_nft::description(&nft)) == b"a new description", 0);
            test_scenario::return_owned(&mut scenario, nft);
        };
        // burn it
        test_scenario::next_tx(&mut scenario, &addr2);
        {
            let nft = test_scenario::take_owned<DinoNFT>(&mut scenario);
            dino_nft::burn(nft, test_scenario::ctx(&mut scenario))
        }
    }
}