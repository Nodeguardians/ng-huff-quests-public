// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import { HuffDeployer } from "./HuffDeployer.sol";
import "../../contracts/DarkHuffoor.sol";

import "forge-std/console.sol";

abstract contract TestHuffoorMage is Test {
    
    uint256 immutable seed;

    address mage;

    constructor(uint256 _seed) {
        seed = _seed;
    }

    function setUp() external {
        mage = (new HuffDeployer()).deploy(
            "contracts/HuffoorMage.huff"
        );
    }
        
    function _test_battle(uint256 _gasLimit) internal {

        DarkHuffoor darkHuffoor = new DarkHuffoor(_gasLimit);

        darkHuffoor.attack(
            mage, keccak256(abi.encode(seed))
        );

        require(darkHuffoor.health() == 0, "Dark Huffoor not defeated!");

    }


}