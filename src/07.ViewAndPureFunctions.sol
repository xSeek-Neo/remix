// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ViewAndPureFunctions {
    uint public num = 456;

    function viewFunc() external view returns (uint) {
        return num; // 可以读取状态变量
    }

    function pureFunc() external pure returns (uint) {
        return 123; // 不能读取状态变量
    }

    function addToNum(uint x) external view returns (uint) {
        return num + x; // 可以读取状态变量
    }

    function add(uint x, uint y) external pure returns (uint) {
        return x + y; // 不能读取状态变量
    }
}