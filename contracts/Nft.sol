// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract OnChainNFT is ERC721 {
    using Strings for uint256;
    uint256 public _tokenIdCounter;
// Constructor initializes the ERC721 token with name and symbol
    constructor() ERC721("IdealzWeb3NFT", "IDNFT") {
        _tokenIdCounter =1; 
        //this here is the token ID counter, it will start from 1
    }
//funstion to mint a new NFT
    function mint() public {
        _safeMint(msg.sender, _tokenIdCounter);
        _tokenIdCounter++;
    }    
// Override the tokenURI function to provide on-chain metadata
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        // Check if the token exists using ownerOf
        try this.ownerOf(tokenId) returns (address) {
            // Token exists, proceed with generating metadata
            string memory name = string(abi.encodePacked("OnChainNFT #", tokenId.toString()));
            string memory description = "This is an on-chain NFT with metadata stored entirely on the blockchain.";
            string memory image = generateBase64Image();

            // Encode metadata in JSON format
            string memory json = Base64.encode(
                bytes(
                    string(
                        abi.encodePacked(
                            '{"name":"', name, '",',
                            '"description":"', description, '",',
                            '"image":"data:image/svg+xml;base64,', image, '"}'                       )
                    )
                )

            );

            return string(abi.encodePacked("data:application/json;base64,", json));
        } catch {
            // Token does not exist
            revert("Token does not exist");
        }
    }

    // Function to generate a base64-encoded SVG image
    function generateBase64Image() internal pure returns (string memory) {
        // Define a simple SVG image
        string memory svg = '<svg xmlns="http://www.w3.org/2000/svg" width="200" height="200" viewBox="0 0 200 200">'
        '<rect width="200" height="200" fill="#4CAF50"/>'
        '<text x="50%" y="50%" dominant-baseline="middle" text-anchor="middle" fill="white" font-size="24">'
        "IdealzNFT"
        "</text>"
        '</svg>';
        return Base64.encode(bytes(svg));
    }
}