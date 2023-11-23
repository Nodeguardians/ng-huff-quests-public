// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { TestHuffoorMage } from "./testsuites/TestHuffoorMage.sol";
import { IMage } from "../contracts/DarkHuffoor.sol";

contract PublicTest1 is TestHuffoorMage {

    constructor() TestHuffoorMage(1) { }

    function test_battle() external {
        _test_battle(25000);
    }

}

contract PublicTest2 is TestHuffoorMage {

    constructor() TestHuffoorMage(2) { }

    function test_battle() external {
        _test_battle(25000);
    }

    function test_unknown_selector() external {
        bytes4 mask = bytes4(uint32(1));
        for (; mask != bytes4(0); mask <<= 1) {
            bytes4 invalidSelector = mask ^ IMage.takeDamage.selector;
            (bool success,) = mage.call(abi.encodeWithSelector(
                invalidSelector, keccak256(abi.encode(seed))
            ));

            require(!success, "Should fail for unknown selector!");
        }
    }
}
