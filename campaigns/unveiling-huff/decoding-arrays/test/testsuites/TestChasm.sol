// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "forge-std/Test.sol";

import { HuffDeployer } from "./HuffDeployer.sol";

interface IChasm {
    error DeadlyPathError();

    function definePath(uint256[] memory path) external;
    function getPath() external view returns (uint256[] memory path);
    function travelPath(uint256 horseStrength, uint256 horseWeight) external view;
}

abstract contract TestChasm1 is Test {
    IChasm chasm;

    uint256[] path;

    constructor(uint256[] memory _path) {
        path = _path;

        HuffDeployer deployer = new HuffDeployer();
        chasm = IChasm(deployer.deploy("contracts/Chasm.huff"));
    }

    function test_define_and_get_path() external {
        chasm.definePath(path);
        uint256[] memory returnedPath = chasm.getPath();

        assertEq(returnedPath, path, "Unexpected path");
    }
}

abstract contract TestChasm2 is Test {
    IChasm chasm;

    uint256[] path;

    constructor(uint256[] memory _path) {
        path = _path;

        HuffDeployer deployer = new HuffDeployer();
        chasm = IChasm(deployer.deploy("contracts/Chasm.huff"));

        chasm.definePath(path);
    }

    function test_travel_strength_0_weight_10() external {
        _testTravel(0, 10);
    }

    function test_travel_strength_0_weight_20() external {
        _testTravel(0, 20);
    }

    function test_travel_strength_1_weight_20() external {
        _testTravel(1, 20);
    }

    function test_travel_strength_1_weight_40() external {
        _testTravel(1, 40);
    }

    function test_travel_strength_2_weight_40() external {
        _testTravel(2, 40);
    }

    function test_travel_strength_3_weight_40() external {
        _testTravel(3, 40);
    }

    function _testTravel(
        uint256 horseStrength,
        uint256 horseWeight
    ) private {
        if (!_travelPath(horseStrength, horseWeight)) {
            vm.expectRevert(IChasm.DeadlyPathError.selector);
        }
        chasm.travelPath(horseStrength, horseWeight);
    }

    // Solidity Implementation
    function _travelPath(
        uint256 horseStrength,
        uint256 horseWeight
    ) private view returns (bool) {

        uint256 leapCtr = 0;
        for (uint256 i = 0; i < path.length; i++) {
            if (horseWeight <= path[i]) { 
                leapCtr = 0;
                continue; 
            }
            
            leapCtr++;
            if (leapCtr > horseStrength) {
                return false;
            }
        }

        return true;
    }
}