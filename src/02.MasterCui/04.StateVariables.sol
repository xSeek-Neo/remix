// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StateVariables {
    // 状态变量
    uint public state = 123;

    // notStateVariables 这个变量只有在update被调用时在内容中产生

    function update() external pure {
        uint notStateVariables = 456;
    }
}
