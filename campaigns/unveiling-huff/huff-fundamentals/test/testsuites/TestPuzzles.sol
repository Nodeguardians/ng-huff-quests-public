// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";

import { HuffDeployer } from "./HuffDeployer.sol";

interface IPuzzleContract {

    function puzzle1(uint256 w, uint256 x, uint256 y,uint256 z) 
        external view returns (uint256);
    
    function puzzle2(uint256 x) external view returns (uint256);
    function puzzle3(uint256 x, uint256 y) external view returns (uint256);
    function puzzle4(uint256 x) external view returns (uint256, uint256);
    
}

abstract contract TestPuzzles is Test {

    IPuzzleContract puzzleContract;

    constructor() {
        HuffDeployer deployer = new HuffDeployer();
        puzzleContract = IPuzzleContract(deployer.deploy("contracts/Contract.huff"));
    }
    
    function _test_puzzle_1(uint256 w, uint256 x, uint256 y, uint256 z) internal {
        
        uint256 actual = puzzleContract.puzzle1(w, x, y, z);

        uint256 expected = w + x + y + z - 1000;
        assertEq(actual, expected, "Unexpected Result");
    }

    function _test_puzzle_2(uint256 x) internal {
        uint256 actual = puzzleContract.puzzle2(x);

        uint256 expected = 2 * (x * x) + (7 * x) + 9;
        assertEq(actual, expected, "Unexpected Result");
    }

    function _test_puzzle_3(uint256 x, uint256 y) internal {
        uint256 actual = puzzleContract.puzzle3(x, y);

        uint256 expected =  (x < y) 
            ? _euclidean(x, y)
            : _euclidean(y, x);

        assertEq(actual, expected, "Unexpected Result");
    }

    function _test_puzzle_4(uint256 x) internal {
        (uint256 actual1, uint256 actual2) = puzzleContract.puzzle4(x);

        // Fibonacci Sequence
        uint256 expected1 = 0;
        uint256 expected2 = 1;
        for (uint256 i = 0; i < x; i++) {

            uint256 temp = expected2;
            expected2 = expected1 + expected2;
            expected1 = temp;

        }

        assertEq(actual1, expected1, "Unexpected Result");
        assertEq(actual2, expected2, "Unexpected Result");
    }

    function _euclidean(uint256 a, uint256 b) private pure returns (uint256) {
        if (a == 0) {
            return b;
        }
        
        return _euclidean(b % a, a);
    }
}