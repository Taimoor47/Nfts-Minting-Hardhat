// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Nft is ERC721, ERC721URIStorage, Ownable {
    constructor(address _tokenaddress) ERC721("Pluton", "PLT") {
        tokenAddress = IERC20(_tokenaddress);
        baseURI = "https://gateway.pinata.cloud/ipfs/";
    }

    // Struct
    struct nftinfo {
        string Hash;
    }

    // Veriables
    IERC20 public tokenAddress;
    uint256 public maxMintLimit;
    string public baseURI;
    uint256 public checkPrice = 0.5 ether;

    // Mapping
    mapping(uint256 => nftinfo) public NftData;

    // Event
    event MintedNft(address _address,uint256 tokenId,uint256 price);

    // Custom Errors
    error MaxLimitReached(uint256 limit);
    error PriceNotEqual(uint256 price);

    // Miniting Funciton
    function mintNft(
        uint256 tokenId,
        uint256 price,
        string memory _metadataHash
    ) public {
        if (maxMintLimit >= 3)
        revert MaxLimitReached(maxMintLimit);
        if (price == 0.5 ether){
        tokenAddress.transferFrom(msg.sender, address(this), price);
        _safeMint(msg.sender, tokenId);
        NftData[tokenId] = nftinfo( _metadataHash);
        maxMintLimit++;
        emit MintedNft(msg.sender,tokenId,price);

        }else{
        revert PriceNotEqual(price);

        }
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId)
        internal
        override(ERC721, ERC721URIStorage)
    {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return
            string(
                abi.encodePacked(
                    baseURI,
                    NftData[tokenId].Hash
                )
            );
    }
}
