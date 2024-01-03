// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { TestPuzzles } from "./testsuites/TestPuzzles.sol";

contract PublicTest1 is TestPuzzles {

    function test_puzzle_1() external {
        _test_puzzle_1(123, 234, 345, 456);
        _test_puzzle_1(9876, 0, 8765, 7654);
    }

    function test_puzzle_2() external {
        _test_puzzle_2(11);
        _test_puzzle_2(0);
    }

}

contract PublicTest2 is TestPuzzles {
    
    function test_puzzle_3() external {
        _test_puzzle_3(42, 126);
        _test_puzzle_3(59, 31);
    }

    function test_puzzle_4() external {
        _test_puzzle_4(6);
        _test_puzzle_4(0);
    }

}
