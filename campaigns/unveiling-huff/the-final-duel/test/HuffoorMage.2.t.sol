// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { TestHuffoorMage } from "./testsuites/TestHuffoorMage.sol";

contract PublicTest1 is TestHuffoorMage {

    constructor() TestHuffoorMage(123) { }

    function test_battle_7200_gas() external {
        _test_battle(7200);
    }

    function test_battle_3600_gas() external {
        _test_battle(3600);
    }
    
    function test_battle_1800_gas() external {
        _test_battle(1800);
    }

}

contract PublicTest2 is TestHuffoorMage {

    constructor() TestHuffoorMage(234) { }

    function test_battle_7200_gas() external {
        _test_battle(7200);
    }

    function test_battle_3600_gas() external {
        _test_battle(3600);
    }
    
    function test_battle_1800_gas() external {
        _test_battle(1800);
    }
}
