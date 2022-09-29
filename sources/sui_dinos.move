// Copyright (c) 2022, Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0

/// A minimalist example to demonstrate how to create an NFT like object
/// on Sui. The user should be able to use the wallet command line tool
/// (https://docs.sui.io/build/wallet) to mint an NFT. For example,
/// `wallet example-nft --name <Name> --description <Description> --url <URL>`
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
        // dino egg optional field
        dino_egg: Option<ID>,
    }

    struct EggNFT has key, store {
        id: UID,
        /// Name for the token
        name: string::String,
        /// Description of the token
        description: string::String,
        /// URL for the token
        url: Url,
        // TODO: allow custom attributes
    }   

    struct MintNFTEvent has copy, drop {
        // The Object ID of the NFT
        object_id: ID,
        // The creator of the NFT
        creator: address,
        // The name of the NFT
        name: string::String,
    }

    /// Create a new devnet_nft
    public entry fun mint_dino(
        name: vector<u8>,
        description: vector<u8>,
        url: vector<u8>,
        ctx: &mut TxContext
    ) {
        let nft = DinoNFT {
            id: object::new(ctx),
            name: string::utf8(name),
            description: string::utf8(description),
            url: url::new_unsafe_from_bytes(url),
            dino_egg: option::none(),
        };
        let sender = tx_context::sender(ctx);
        event::emit(MintNFTEvent {
            object_id: object::uid_to_inner(&nft.id),
            creator: sender,
            name: nft.name,
        });
        transfer::transfer(nft, sender);
    }

    public entry fun mint_egg(
        name: vector<u8>,
        description: vector<u8>,
        url: vector<u8>,
        ctx: &mut TxContext
    ) {
        let nft = EggNFT {
            id: object::new(ctx),
            name: string::utf8(name),
            description: string::utf8(description),
            url: url::new_unsafe_from_bytes(url)
        };
        let sender = tx_context::sender(ctx);
        event::emit(MintNFTEvent {
            object_id: object::uid_to_inner(&nft.id),
            creator: sender,
            name: nft.name,
        });
        transfer::transfer(nft, sender);
    }

    public entry fun add_egg(dino: &mut DinoNFT, egg: EggNFT) {
        option::fill(&mut dino.dino_egg, object::id(&egg));
        transfer::transfer_to_object(egg, dino);
    }

    public entry fun mint_and_give_egg(
        name: vector<u8>,
        description: vector<u8>,
        url: vector<u8>,
        dino: &mut DinoNFT,
        ctx: &mut TxContext
    ) {
        let nft = EggNFT {
            id: object::new(ctx),
            name: string::utf8(name),
            description: string::utf8(description),
            url: url::new_unsafe_from_bytes(url)
        };
        let sender = tx_context::sender(ctx);
        event::emit(MintNFTEvent {
            object_id: object::uid_to_inner(&nft.id),
            creator: sender,
            name: nft.name,
        });
        option::fill(&mut dino.dino_egg, object::id(&nft));
        transfer::transfer_to_object(nft, dino);
    }

    /// Update the `description` of `nft` to `new_description`
    public entry fun update_description(
        nft: &mut DinoNFT,
        new_description: vector<u8>,
        _: &mut TxContext
    ) {
        nft.description = string::utf8(new_description)
    }

    /// Update the `description` of `nft` to `new_description`
    public entry fun update_child_nft(
        child_nft: &mut EggNFT,
        _parent_nft: &mut DinoNFT,
        _: &mut TxContext
    ) {
        child_nft.name = string::utf8(b"Baby Dino NFT");
        child_nft.description = string::utf8(b"Hatched Dino NFT");
        child_nft.url = url::new_unsafe_from_bytes(b"https://i5.walmartimages.com/asr/f9653453-7d31-45bc-af26-51a027f16d23_1.76b701b2bf1fddb47a3f823807c1999f.jpeg")
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
module sui_intro_workshop::devnet_nftTests {
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
            dino_nft::mint_dino(b"test", b"a test", b"https://www.sui.io", test_scenario::ctx(&mut scenario))
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