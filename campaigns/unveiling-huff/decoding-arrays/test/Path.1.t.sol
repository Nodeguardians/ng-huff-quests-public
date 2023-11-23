// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { TestChasm1 } from "./testsuites/TestChasm.sol";

contract PublicTest1 is TestChasm1 {

    function getInput() private pure returns (uint256[] memory) {
        uint256[] memory path = new uint256[](9);

        path[1] = 22;
        path[2] = 33;
        path[3] = 44;
        path[4] = 55;
        path[5] = 66;
        path[6] = 77;
        path[7] = 88;
        path[8] = 99;

        return path;
    }

    constructor() TestChasm1(getInput()) { }
}

contract PublicTest2 is TestChasm1 {

    function getInput() private pure returns (uint256[] memory) {
        uint256[] memory path = new uint256[](3);

        path[0] = 11;
        path[1] = 22;
        path[2] = 33;

        return path;
    }

    constructor() TestChasm1(getInput()) { }

    function test_define_and_get_empty_path() external {
        uint256[] memory emptyPath = new uint256[](0);
        chasm.definePath(emptyPath);

        uint256[] memory returnedPath = chasm.getPath();

        assertEq(returnedPath, emptyPath, "Unexpected path");
    }
}