// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { TestTownDefenseV2 } from "./testsuites/TestTownDefenseV2.sol";

contract PublicTest1 is TestTownDefenseV2 {

    constructor() TestTownDefenseV2(250) { }
    
}

contract PublicTest2 is TestTownDefenseV2 {

    constructor() TestTownDefenseV2(140) { }
    
}