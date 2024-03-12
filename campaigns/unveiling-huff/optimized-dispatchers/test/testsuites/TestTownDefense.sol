// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";

import { TownDefense } from "./implementation/TownDefense.sol";
import { HuffDeployer } from "./HuffDeployer.sol";

abstract contract TestTownDefense is Test {
    
    uint256 immutable SALT;

    address impl; // Huff implementation to test
    address ref; // Reference implementation in Solidity

    error CallFailed(bytes4 selector);
    error InvalidSelectorPassed(bytes4 selector);
    error UnexpectedResult(bytes4 selector);

    constructor(uint256 _salt) {
        SALT = _salt;
        ref = address(new TownDefense());

        HuffDeployer deployer = new HuffDeployer();
        impl = deployer.deploy("contracts/TownDefense.huff");
    }

    function test_call_reinforcements() external {
        _test_selector(TownDefense.callReinforcements.selector);
    }

    function test_fire_ballista() external {
        _test_selector(TownDefense.fireBallista.selector);
    }

    function test_launch_catapult() external {
        _test_selector(TownDefense.launchCatapult.selector);
    }

    function test_order_archer() external {
        _test_selector(TownDefense.orderArcher.selector);
    }

    function test_order_soldier() external {
        _test_selector(TownDefense.orderSoldier.selector);
    }

    function test_pour_oil() external {
        _test_selector(TownDefense.pourOil.selector);
    }

    function test_raise_wall() external {
        _test_selector(TownDefense.raiseWall.selector);
    }

    function test_reinforce_barrier() external {
        _test_selector(TownDefense.reinforceBarrier.selector);
    }

    function test_send_cavalry() external {
        _test_selector(TownDefense.sendCavalry.selector);
    }

    function test_throw_firepot() external {
        _test_selector(TownDefense.throwFirepot.selector);
    }

    function test_invalid_selectors() external {
        _test_invalid_selector(
            TownDefense.raiseWall.selector ^ bytes4(uint32(SALT))
        );
        _test_invalid_selector(
            TownDefense.orderArcher.selector^ bytes4(uint32(SALT))
        );
    }

    function _test_selector(bytes4 selector) private {
        bytes memory _calldata = abi.encodeWithSelector(selector, SALT);

        (bool success, bytes memory actualData) = impl.call(_calldata);

        if (!success) {
            revert CallFailed(selector);
        }

        (, bytes memory expectedData) = ref.call(_calldata);

        if (keccak256(actualData) != keccak256(expectedData)) {
            revert UnexpectedResult(selector);
        }
    }

    function _test_invalid_selector(bytes4 selector) private {
        bytes memory _calldata = abi.encodeWithSelector(selector);
        (bool success, ) = impl.call(_calldata);

        if (success) {
            revert InvalidSelectorPassed(selector);
        }
    }

}