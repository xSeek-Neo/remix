// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract LocalVariables {
    uint public i;
    bool public b;
    address public addr;

    // 函数内部变量时局部变量 不会被写道区块链上
    function update() external {
        uint x = 123;
        bool f = false;
        // more code
        x += 456;
        f = true;

        i = 123;
        b = true;
        addr = address(1);
    }
}
