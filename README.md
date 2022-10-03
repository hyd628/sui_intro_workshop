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

sui client call --function owner_mint_to_account --module dino_nft --package 0xe8937568e66f1ba3b1e1bd86285176a47a9683bd --args 0xbfdcaf82ec44aafef111544fa8234f26f0c33da3 "Sui Dino NFT" "A Dino NFT minted on Sui" "https://www.ikea.com/sg/en/images/products/jaettelik-soft-toy-dinosaur-dinosaur-stegosaurus__0804790_pe769331_s5.jpg" --gas-budget 1000

sui client addresses

sui client switch --address 0x33b31cad232ee4afa34174ed23107b567e0b7439

sui client call --function owner_mint_to_account --module dino_nft --package 0xe8937568e66f1ba3b1e1bd86285176a47a9683bd --args 0xbfdcaf82ec44aafef111544fa8234f26f0c33da3 "Sui Dino NFT" "A Dino NFT minted on Sui" "https://www.ikea.com/sg/en/images/products/jaettelik-soft-toy-dinosaur-dinosaur-stegosaurus__0804790_pe769331_s5.jpg" --gas-budget 1000

