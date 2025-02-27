    // SPDX-License-Identifier: UNLICENSED
    pragma solidity ^0.8.28;

    import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
    import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol"; // Ownable is a contract that allows you to manage the ownership of a contract  
    import {Base64} from "@openzeppelin/contracts/utils/Base64.sol"; // to encode metadata in a format readable by marketplaces.
    import {Strings} from "@openzeppelin/contracts/utils/Strings.sol"; // To convert strings to bytes and vice versa

    contract OnChainNFT is ERC721, Ownable {
        uint256 tokenCount;

        constructor(
            string memory _name,
            string memory _symbol
        ) ERC721(_name, _symbol) Ownable(msg.sender) {
            mint(msg.sender);
        }

        function mint(address _to) public onlyOwner returns (bool) {
            uint256 tokenId = tokenCount + 1;

            _safeMint(_to, tokenId);

            tokenCount = tokenId;

            return true;
        }

        function tokenURI(
            uint256 tokenId
        ) public view override returns (string memory) {
            string memory uri = Base64.encode(
                bytes(
                    string(
                        abi.encodePacked(
                            '{"name": "',
                            name(),
                            " #",
                            Strings.toString(tokenId),
                            '",',
                            '"description": "Idealz",',
                            '"image": "data:image/svg+xml;base64,',
                            Base64.encode(bytes(SVGImage())),
                            '"}'
                        )
                    )
                )
            );

            return string(abi.encodePacked("data:application/json;base64,", uri));
        }

        function SVGImage() internal pure returns (string memory) {
            return
                '<svg width="100" height="50" xmlns="http://www.w3.org/2000/svg"> <text x="10" y="30" font-family="Arial" font-size="24" fill="blue">Idealz</text></svg>';
        }
    }

    // {"name": "Idealz #1",
    //  "description": "Idealz",
    //  "image": "data:image/svg+xml;base64,1234"}

    // "data:application/json;base64,"
    // data:image/svg+xml;base64,
    // unique id
    // name
    // description
    // symbol
    // image
    // mint
    // burn