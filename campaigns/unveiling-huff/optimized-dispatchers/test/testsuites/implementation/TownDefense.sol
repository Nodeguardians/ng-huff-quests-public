// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract TownDefense {

    function callReinforcements(uint256 n) external pure returns (uint256) {
        return 0x1111 ^ n;
    }

    function fireBallista(uint256 n) external pure returns (uint256) {
        return 0x2222 ^ n;
    } 

    function launchCatapult(uint256 n) external pure returns (uint256) {
        return 0x3333 ^ n;
    } 

    function orderArcher(uint256 n) external pure returns (uint256) {
        return 0x4444 ^ n;
    } 

    function orderSoldier(uint256 n) external pure returns (uint256) {
        return 0x5555 ^ n;
    } 

    function pourOil(uint256 n) external pure returns (uint256) {
        return 0x6666 ^ n;
    } 

    function raiseWall(uint256 n) external pure returns (uint256) {
        return 0x7777 ^ n;
    } 

    function reinforceBarrier(uint256 n) external pure returns (uint256) {
        return 0x8888 ^ n;
    } 

    function sendCavalry(uint256 n) external pure returns (uint256) {
        return 0x9999 ^ n;
    } 

    function throwFirepot(uint256 n) external pure returns (uint256) {
        return 0xAAAA ^ n;
    } 

}