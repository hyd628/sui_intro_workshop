## Demo Sui CLI commands

### Basic Version:

sui client publish --path /Users/henryworkmac/Documents/workspace/sui_intro_workshop --gas-budget 30000

sui client call --function mint --module dino_nft --package 0x8cc2d744c9415975ae384f54142cefd96d32d504 --args "Sui Dino NFT" "A Dino NFT minted on Sui" "https://www.ikea.com/sg/en/images/products/jaettelik-soft-toy-dinosaur-dinosaur-stegosaurus__0804790_pe769331_s5.jpg" --gas-budget 1000

### Child Parent Version:

sui client publish --path /Users/henryworkmac/Documents/workspace/sui_intro_workshop --gas-budget 30000

sui client call --function mint_to_account --module dino_nft --package 0x88803877c7c0f7465db972b3db472f156a663def --args "Sui Dino NFT" "A Dino NFT minted on Sui" "https://www.ikea.com/sg/en/images/products/jaettelik-soft-toy-dinosaur-dinosaur-stegosaurus__0804790_pe769331_s5.jpg" --gas-budget 1000

sui client call --function mint_to_object --module dino_nft --package 0x88803877c7c0f7465db972b3db472f156a663def --args "Sui Dino Egg NFT" "A Dino Egg NFT minted on Sui" "https://pisces.bbystatic.com/image2/BestBuy_US/images/products/6366/6366914cv12d.jpg" "0xcb6d9cca5f6f4d7a309b06e766d68f80f2d0ad28" --gas-budget 1000

sui client call --function hatch_egg --module dino_nft --package 0x88803877c7c0f7465db972b3db472f156a663def --args "Baby Dino NFT" "Hatched Dino NFT" "https://i5.walmartimages.com/asr/f9653453-7d31-45bc-af26-51a027f16d23_1.76b701b2bf1fddb47a3f823807c1999f.jpeg" "0xb5cfa753723d6305430b96c1f6f9b859b579dbff" "0xcb6d9cca5f6f4d7a309b06e766d68f80f2d0ad28" --gas-budget 1000

sui client call --function retrieve_child_dino --module dino_nft --package 0x88803877c7c0f7465db972b3db472f156a663def --args "0xb5cfa753723d6305430b96c1f6f9b859b579dbff" "0xcb6d9cca5f6f4d7a309b06e766d68f80f2d0ad28" --gas-budget 1000

### Access Control Version:

sui client publish --path /Users/henryworkmac/Documents/workspace/sui_intro_workshop --gas-budget 30000

sui client call --function owner_mint_to_account --module dino_nft --package 0x063fc7eafe8dea7a4a984bc8ff476c344f0b2f59 --args 0x7f2e5947ae28fb8400afab56eee94113ca796572 "Sui Dino NFT" "A Dino NFT minted on Sui" "https://www.ikea.com/sg/en/images/products/jaettelik-soft-toy-dinosaur-dinosaur-stegosaurus__0804790_pe769331_s5.jpg" --gas-budget 1000

sui client addresses

sui client switch --address 0x33b31cad232ee4afa34174ed23107b567e0b7439

sui client call --function owner_mint_to_account --module dino_nft --package 0x063fc7eafe8dea7a4a984bc8ff476c344f0b2f59 --args 0x7f2e5947ae28fb8400afab56eee94113ca796572 "Sui Dino NFT" "A Dino NFT minted on Sui" "https://www.ikea.com/sg/en/images/products/jaettelik-soft-toy-dinosaur-dinosaur-stegosaurus__0804790_pe769331_s5.jpg" --gas-budget 1000

(paid mint)

sui client call --function mint_to_account --module dino_nft --package 0x8faafda44b58a56d5f3cf22bbcbee60d308baa94 --args 0xd80764d8663056354861d5274c73b8df77892aa1 "Sui Dino NFT" "A Dino NFT minted on Sui" "https://www.ikea.com/sg/en/images/products/jaettelik-soft-toy-dinosaur-dinosaur-stegosaurus__0804790_pe769331_s5.jpg" 0x33a34d986f6fa38e76304fbeee1ac36da4734299 --gas-budget 1000

(withdrawal)

sui client call --function owner_withdraw --module dino_nft --package 0xce92852eee84d0fb483878dfcea051ad6b9b39af --args 0x1026b22b00ae47553e8206258d29cda47a2b0f80 0x64bf57b21b50215c34297fce647669f5aae3a012  --gas-budget 1000