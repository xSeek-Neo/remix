// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Func {
    // pure 纯函数 这个函数不能够读 也不能读写状态变量 只能有局部变量
    function add(uint x, uint y) external pure returns (uint) {
        return x + y;
    }

    function sub(uint x, uint y) external pure returns (uint) {
        return x - y;
    }
}
