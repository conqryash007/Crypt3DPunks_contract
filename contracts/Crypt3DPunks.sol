// SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

import "erc721a/contracts/ERC721A.sol";

error QUANTITY_NOT_FOUND();

contract Crypt3DPunks is ERC721A {
    constructor() ERC721A("Crypt3DPunks", "C3DP") {}

    uint256[] public roundQuantity = [
        0,
        500,
        1250,
        2000,
        3000,
        4000,
        5000,
        6000,
        7000,
        8000,
        9000
    ];

    uint256[] public round1Price = [
        0.060 ether,
        0.114 ether,
        0.162 ether,
        0.204 ether,
        0.240 ether,
        0.420 ether
    ];

    uint256[] public round2Price = [
        0.063 ether,
        0.120 ether,
        0.170 ether,
        0.214 ether,
        0.252 ether,
        0.441 ether
    ];

    uint256[] public round3Price = [
        0.066 ether,
        0.126 ether,
        0.179 ether,
        0.225 ether,
        0.265 ether,
        0.463 ether
    ];

    uint256[] public round4Price = [
        0.069 ether,
        0.132 ether,
        0.188 ether,
        0.236 ether,
        0.278 ether,
        0.486 ether
    ];

    uint256[] public round5Price = [
        0.073 ether,
        0.139 ether,
        0.197 ether,
        0.248 ether,
        0.292 ether,
        0.511 ether
    ];

    uint256[] public round6Price = [
        0.077 ether,
        0.145 ether,
        0.207 ether,
        0.260 ether,
        0.306 ether,
        0.536 ether
    ];

    uint256[] public round7Price = [
        0.080 ether,
        0.153 ether,
        0.217 ether,
        0.273 ether,
        0.322 ether,
        0.563 ether
    ];

    uint256[] public round8Price = [
        0.084 ether,
        0.160 ether,
        0.228 ether,
        0.287 ether,
        0.338 ether,
        0.591 ether
    ];

    uint256[] public round9Price = [
        0.089 ether,
        0.168 ether,
        0.239 ether,
        0.301 ether,
        0.355 ether,
        0.621 ether
    ];

    uint256[] public round10Price = [
        0.093 ether,
        0.177 ether,
        0.251 ether,
        0.316 ether,
        0.372 ether,
        0.652 ether
    ];

    string public baseURI = "http://crypto3dpunk.io/punks/api/";

    uint256 public constant MAX_MINT_CAP = 9000;

    // CHECKS
    // => Quatntity should be 1,2,3,4,5,10
    // 1. nextMintIndex should be less than equal to max mint cap
    // 2. currentRound(nextMintIndex) == currentRound(nextMintIndex + quantity - 1)
    // 3. The user has send required amount ether
    function mintCrypt3DPunk(uint256 _quantity) external payable {
        uint256 priceIdx;
        if (
            _quantity == 1 ||
            _quantity == 2 ||
            _quantity == 3 ||
            _quantity == 4 ||
            _quantity == 5 ||
            _quantity == 10
        ) {
            if (_quantity == 10) {
                priceIdx = 5;
            } else {
                priceIdx = _quantity - 1;
            }
        } else {
            revert QUANTITY_NOT_FOUND();
        }
        uint256 nextMintIdx = _nextTokenId();

        require(nextMintIdx <= MAX_MINT_CAP, "MAX LIMIT EXCEEDED");

        require(
            _getCurrentRoundNumber(nextMintIdx) ==
                _getCurrentRoundNumber(nextMintIdx + _quantity - 1),
            "CANNOT BE MINTED IN THIS GROUP"
        );

        uint256 currRound = _getCurrentRoundNumber(nextMintIdx);
        uint256[] memory currRoundPrice = _getCurrentRoundPrice(currRound);

        require(
            msg.value >= currRoundPrice[priceIdx],
            "INSUFFICIENT AMOUNT OF ETHER SEND"
        );

        _mint(msg.sender, _quantity);
    }

    function _getCurrentRoundNumber(uint256 _tokenIdx)
        internal
        view
        returns (uint256 _currRound)
    {
        if (_tokenIdx > roundQuantity[0] && _tokenIdx <= roundQuantity[1]) {
            _currRound = 1;
        } else if (
            _tokenIdx > roundQuantity[1] && _tokenIdx <= roundQuantity[2]
        ) {
            _currRound = 2;
        } else if (
            _tokenIdx > roundQuantity[2] && _tokenIdx <= roundQuantity[3]
        ) {
            _currRound = 3;
        } else if (
            _tokenIdx > roundQuantity[3] && _tokenIdx <= roundQuantity[4]
        ) {
            _currRound = 4;
        } else if (
            _tokenIdx > roundQuantity[4] && _tokenIdx <= roundQuantity[5]
        ) {
            _currRound = 5;
        } else if (
            _tokenIdx > roundQuantity[5] && _tokenIdx <= roundQuantity[6]
        ) {
            _currRound = 6;
        } else if (
            _tokenIdx > roundQuantity[6] && _tokenIdx <= roundQuantity[7]
        ) {
            _currRound = 7;
        } else if (
            _tokenIdx > roundQuantity[7] && _tokenIdx <= roundQuantity[8]
        ) {
            _currRound = 8;
        } else if (
            _tokenIdx > roundQuantity[8] && _tokenIdx <= roundQuantity[9]
        ) {
            _currRound = 9;
        } else if (
            _tokenIdx > roundQuantity[9] && _tokenIdx <= roundQuantity[10]
        ) {
            _currRound = 10;
        }
    }

    function _getCurrentRoundPrice(uint256 _round)
        internal
        view
        returns (uint256[] memory roundPrice)
    {
        if (_round == 1) {
            roundPrice = round1Price;
        } else if (_round == 2) {
            roundPrice = round2Price;
        } else if (_round == 3) {
            roundPrice = round3Price;
        } else if (_round == 4) {
            roundPrice = round4Price;
        } else if (_round == 5) {
            roundPrice = round5Price;
        } else if (_round == 6) {
            roundPrice = round6Price;
        } else if (_round == 7) {
            roundPrice = round7Price;
        } else if (_round == 8) {
            roundPrice = round8Price;
        } else if (_round == 9) {
            roundPrice = round9Price;
        } else if (_round == 10) {
            roundPrice = round10Price;
        }

        return roundPrice;
    }

    // SET TOKEN URI FUNCTION

    function _startTokenId() internal pure override returns (uint256) {
        return 1;
    }

    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }
}
