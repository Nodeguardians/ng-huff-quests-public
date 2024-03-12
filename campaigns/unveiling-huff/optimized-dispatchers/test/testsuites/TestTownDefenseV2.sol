// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";

import { TownDefenseV2 } from "./implementation/TownDefenseV2.sol";
import { HuffDeployer } from "./HuffDeployer.sol";

abstract contract TestTownDefenseV2 is Test {
    
    uint256 SALT;

    address impl; // Huff implementation to test
    address ref; // Reference implementation in Solidity
    uint256 gasLimit;

    error CallFailed(bytes4 selector);
    error InvalidSelectorPassed(bytes4 selector);
    error UnexpectedResult(bytes4 selector);
    error NotEnoughGas(bytes4 selector);

    constructor(uint256 _gasLimit) {
        gasLimit = _gasLimit;
        ref = address(new TownDefenseV2());

        HuffDeployer deployer = new HuffDeployer();
        impl = deployer.deploy("contracts/TownDefenseV2.huff");
    }

    function test_call_reinforcements() external {
        _test_selector(TownDefenseV2.callReinforcements1.selector);
        _test_selector(TownDefenseV2.callReinforcements2.selector);
        _test_selector(TownDefenseV2.callReinforcements3.selector);
        _test_selector(TownDefenseV2.callReinforcements4.selector);
    }

    function test_fire_ballista() external {
        _test_selector(TownDefenseV2.fireBallista1.selector);
        _test_selector(TownDefenseV2.fireBallista2.selector);
        _test_selector(TownDefenseV2.fireBallista3.selector);
        _test_selector(TownDefenseV2.fireBallista4.selector);
    }

    function test_launch_catapult() external {
        _test_selector(TownDefenseV2.launchCatapult1.selector);
        _test_selector(TownDefenseV2.launchCatapult2.selector);
        _test_selector(TownDefenseV2.launchCatapult3.selector);
        _test_selector(TownDefenseV2.launchCatapult4.selector);
    }

    function test_order_archer() external {
        _test_selector(TownDefenseV2.orderArcher1.selector);
        _test_selector(TownDefenseV2.orderArcher2.selector);
        _test_selector(TownDefenseV2.orderArcher3.selector);
        _test_selector(TownDefenseV2.orderArcher4.selector);
    }

    function test_order_soldier() external {
        _test_selector(TownDefenseV2.orderSoldier1.selector);
        _test_selector(TownDefenseV2.orderSoldier2.selector);
        _test_selector(TownDefenseV2.orderSoldier3.selector);
        _test_selector(TownDefenseV2.orderSoldier4.selector);
    }

    function test_pour_oil() external {
        _test_selector(TownDefenseV2.pourOil1.selector);
        _test_selector(TownDefenseV2.pourOil2.selector);
        _test_selector(TownDefenseV2.pourOil3.selector);
        _test_selector(TownDefenseV2.pourOil4.selector);
    }

    function test_raise_wall() external {
        _test_selector(TownDefenseV2.raiseWall1.selector);
        _test_selector(TownDefenseV2.raiseWall2.selector);
        _test_selector(TownDefenseV2.raiseWall3.selector);
        _test_selector(TownDefenseV2.raiseWall4.selector);
    }

    function test_reinforce_barrier() external {
        _test_selector(TownDefenseV2.reinforceBarrier1.selector);
        _test_selector(TownDefenseV2.reinforceBarrier2.selector);
        _test_selector(TownDefenseV2.reinforceBarrier3.selector);
        _test_selector(TownDefenseV2.reinforceBarrier4.selector);
    }

    function test_send_cavalry() external {
        _test_selector(TownDefenseV2.sendCavalry1.selector);
        _test_selector(TownDefenseV2.sendCavalry2.selector);
        _test_selector(TownDefenseV2.sendCavalry3.selector);
        _test_selector(TownDefenseV2.sendCavalry4.selector);
    }

    function test_throw_firepot() external {
        _test_selector(TownDefenseV2.throwFirepot1.selector);
        _test_selector(TownDefenseV2.throwFirepot2.selector);
        _test_selector(TownDefenseV2.throwFirepot3.selector);
        _test_selector(TownDefenseV2.throwFirepot4.selector);
    }

    function test_invalid_selectors() external {
        _test_invalid_selector(TownDefenseV2.throwFirepot1.selector ^ bytes4(uint32(1)));
        _test_invalid_selector(TownDefenseV2.throwFirepot1.selector ^ bytes4(0x80000000));
        _test_invalid_selector(TownDefenseV2.sendCavalry4.selector ^ bytes4(uint32(1)));
        _test_invalid_selector(TownDefenseV2.sendCavalry4.selector ^ bytes4(0x80000000));
    }

    function _test_selector(bytes4 selector) private {

        // 1. Test without gas limit first
        bytes memory _calldata = abi.encodeWithSelector(selector);

        (bool success, bytes memory actualData) = impl.call(_calldata);

        if (!success) {
            revert CallFailed(selector);
        }

        (, bytes memory expectedData) = ref.call(_calldata);
        if (keccak256(actualData) != keccak256(expectedData)) {
            revert UnexpectedResult(selector);
        }

        // 2. Test again, with gas limit
        (success, actualData) = impl.call{ gas: gasLimit }(_calldata);

        if (!success) {
            revert NotEnoughGas(selector);
        }

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