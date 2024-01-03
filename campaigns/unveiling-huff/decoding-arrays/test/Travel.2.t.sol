// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { TestChasm2 } from "./testsuites/TestChasm.sol";

contract PublicTest1 is TestChasm2 {

    function getInput() private pure returns (uint256[] memory) {
        uint256[] memory path = new uint256[](10);

        path[0] = 60;
        path[1] = 50;
        path[2] = 10;
        path[3] = 30;
        path[4] = 50;
        path[5] = 30;
        path[6] = 10;
        path[7] = 50;
        path[8] = 30;
        path[9] = 50;


        return path;
    }

    constructor() TestChasm2(getInput()) { }
}

contract PublicTest2 is TestChasm2 {

    function getInput() private pure returns (uint256[] memory) {
        uint256[] memory path = new uint256[](14);

        path[0] = 50;
        path[1] = 50;
        path[2] = 50;
        path[3] = 30;
        path[4] = 30;
        path[5] = 30;
        path[6] = 50;
        path[7] = 50;
        path[8] = 50;
        path[9] = 20;
        path[10] = 20;
        path[11] = 50;
        path[12] = 50;
        path[13] = 50;


        return path;
    }

    constructor() TestChasm2(getInput()) { }
}