//Contract based on [https://docs.openzeppelin.com/contracts/3.x/erc721](https://docs.openzeppelin.com/contracts/3.x/erc721)
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract MyNFT is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    
    
    uint256 public cost = 0.11 ether;
    uint256 public maxSupply = 11111;
    uint256 public maxMintAmount = 20;
    bool public paused = false;
    bool public presale = false;
    mapping(address => bool) public whitelisted;
  

    constructor() ERC721("Wooshi", "NFT") {}

    function mintNFT(address recipient, string memory tokenURI, uint256 mintAmount)
        public payable
        returns (uint256)
    {
        require(!paused);
        if (presale)
        {
            require(whitelisted[msg.sender]);
        }
        require(mintAmount > 0);
        require(mintAmount <= maxMintAmount);
        require(msg.value >= cost * mintAmount, "Not enough ETH sent; check price!");
        require(_tokenIds.current() + mintAmount <= maxSupply); // check if tokens are not up to max supply

        uint256 newItemId;
        
        for (uint256 i = 1; i <= mintAmount; i++) {
            _tokenIds.increment();
            newItemId = _tokenIds.current();
            _mint(recipient, newItemId);
            _setTokenURI(newItemId, tokenURI);
        }

        return newItemId;
    }
}









