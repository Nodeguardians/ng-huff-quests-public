// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { TestTownDefense } from "./testsuites/TestTownDefense.sol";

contract PublicTest1 is TestTownDefense {

    constructor() TestTownDefense(0x1337) { }

}

contract PublicTest2 is TestTownDefense {

    constructor() TestTownDefense(0xdead) { }

}