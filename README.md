# sui_intro_workshop
 Sui Move 101 Workshop Repo

Demo Sui CLI commands

Basic Version:

sui client publish --path /Users/henryworkmac/Documents/workspace/sui_intro_workshop --gas-budget 30000

sui client call --function mint --module dino_nft --package 0x7d54bf7c28f048433146a49bc932365d8a0b0a4f --args "Sui Dino NFT" "A Dino NFT minted on Sui" "https://www.ikea.com/sg/en/images/products/jaettelik-soft-toy-dinosaur-dinosaur-stegosaurus__0804790_pe769331_s5.jpg" --gas-budget 1000

Child Parent Version:

sui client publish --path /Users/henryworkmac/Documents/workspace/sui_intro_workshop --gas-budget 30000

sui client call --function mint_to_account --module dino_nft --package 0x8880c42e5a2afb9d4517c19c0a0e2d356d844c70 --args "Sui Dino NFT" "A Dino NFT minted on Sui" "https://www.ikea.com/sg/en/images/products/jaettelik-soft-toy-dinosaur-dinosaur-stegosaurus__0804790_pe769331_s5.jpg" --gas-budget 1000

sui client call --function mint_to_object --module dino_nft --package 0x8880c42e5a2afb9d4517c19c0a0e2d356d844c70 --args "Sui Dino Egg NFT" "A Dino Egg NFT minted on Sui" "https://pisces.bbystatic.com/image2/BestBuy_US/images/products/6366/6366914cv12d.jpg" "0x4a0e70f4231962e06caac60ec3364338ba0b9565" --gas-budget 1000

sui client call --function hatch_egg --module dino_nft --package 0x8880c42e5a2afb9d4517c19c0a0e2d356d844c70 --args "Baby Dino NFT" "Hatched Dino NFT" "https://i5.walmartimages.com/asr/f9653453-7d31-45bc-af26-51a027f16d23_1.76b701b2bf1fddb47a3f823807c1999f.jpeg" "0x582c0e288bbd640fa0d4eec2ee6221752ba69b9f" "0x4a0e70f4231962e06caac60ec3364338ba0b9565" --gas-budget 1000

sui client call --function retrieve_child_dino --module dino_nft --package 0x8880c42e5a2afb9d4517c19c0a0e2d356d844c70 --args "0x582c0e288bbd640fa0d4eec2ee6221752ba69b9f" "0x4a0e70f4231962e06caac60ec3364338ba0b9565" --gas-budget 1000

Access Control Version:

sui client publish --path /Users/henryworkmac/Documents/workspace/sui_intro_workshop --gas-budget 30000

sui client call --function mint_to_account --module dino_nft --package 0xcc9998cc9b4cf36450a521f72c094596efc6611e --args 0x0c8fb0e625a3c505108b1acc0b0bbb9f46e02040 "Sui Dino NFT" "A Dino NFT minted on Sui" "https://www.ikea.com/sg/en/images/products/jaettelik-soft-toy-dinosaur-dinosaur-stegosaurus__0804790_pe769331_s5.jpg" 0x3d90dbb26373587f3d3426dece48f15cc1dbfef4 --gas-budget 1000

sui client call --function mint_to_object --module dino_nft --package 0xf56f97e5d736e07996f41e1b4d21ea8c986f497e --args 0xb544b0a2f8371ae70a07c0110f7951e6fff5d8b7 "Sui Dino Egg NFT" "A Dino Egg NFT minted on Sui" "https://pisces.bbystatic.com/image2/BestBuy_US/images/products/6366/6366914cv12d.jpg" "0x4a017d9f77da89b83528b1613c62663f59358f06" --gas-budget 1000

sui client call --function hatch_egg --module dino_nft --package 0xd945a8ea7ade97bcf6d7f4ba8dc8231fdede2c0c --args "Baby Dino NFT" "Hatched Dino NFT" "https://i5.walmartimages.com/asr/f9653453-7d31-45bc-af26-51a027f16d23_1.76b701b2bf1fddb47a3f823807c1999f.jpeg" "0xa394574d471a5f87da5afe40790e096a48f7552b" "0xa3b51ac77070c83540d4099c01dddfa6b9d28339" --gas-budget 1000

sui client call --function retrieve_child_dino --module dino_nft --package 0xd945a8ea7ade97bcf6d7f4ba8dc8231fdede2c0c --args "0xa394574d471a5f87da5afe40790e096a48f7552b" "0xa3b51ac77070c83540d4099c01dddfa6b9d28339" --gas-budget 1000
