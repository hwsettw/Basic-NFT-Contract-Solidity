// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SimpleMintContract is ERC721, Ownable {
    uint256 public mintPrice = 0.05 ether; // Всё правильно, точка с запятой на месте
    uint256 public totalSupply;
    uint256 public maxSupply;
    bool public isMintEnabled;
    mapping(address => uint256) public mintedWallets;

    constructor() ERC721("Simple Mint", "SIMPLEMINT") Ownable(msg.sender) {
        maxSupply = 2;
    }

    function toggleISMintenabled() external onlyOwner{
        isMintEnabled = !isMintEnabled;
    }

    function setMaxSupply(uint256 _maxSupply) external onlyOwner {
        maxSupply =_maxSupply;
    }

    function mint() external payable {
    require(isMintEnabled, "Minting is not enabled");
    require(mintedWallets[msg.sender] < 1, "Exceeds max per wallet");
    require(msg.value == mintPrice, "Wrong value");
    require(maxSupply > totalSupply, "Sold out");

    mintedWallets[msg.sender]++;
    totalSupply++;
    uint256 tokenId = totalSupply;
    _safeMint(msg.sender, tokenId);
    }
}