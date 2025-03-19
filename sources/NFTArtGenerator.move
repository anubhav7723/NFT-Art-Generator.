module MyModule::NFTArtGenerator {

    use aptos_framework::signer;
    use aptos_framework::token;
    
    struct NFT has key, store {
        creator: address,
        id: u64,
    }

    /// Function to create a unique NFT
    public fun create_nft_art(creator: &signer, id: u64) {
        let nft = NFT {
            creator: signer::address_of(creator),
            id,
        };
        move_to(creator, nft);
    }

    /// Function to transfer NFT to another user
    public fun transfer_nft(sender: &signer, receiver: address, id: u64) acquires NFT {
        let nft = borrow_global_mut<NFT>(signer::address_of(sender));
        assert!(nft.id == id, 1);
        move_to(&receiver, nft);
    }
}
