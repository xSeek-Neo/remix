// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// immutable: 部署时赋值一次，之后不可修改
// 原理：值写入 bytecode 而非 storage 槽位，读取时直接内联到指令中，省 SLOAD 等 storage 操作
// 与 constant 区别：constant 必须编译时确定；immutable 可在构造函数或声明时赋运行时常量（如 msg.sender、block.timestamp）

contract Immutable {
    // 45718 gas - address public owner = msg.sender;  (普通 storage 变量)
    // 43585 gas - immutable 写法，省约 2133 gas
    // 01. 
    address public immutable i_owner = msg.sender;

    // 02.
    address public immutable i_owner2;

    constructor() {
        i_owner2 = msg.sender;
    }

    uint x;

    function foo() external {
        require(msg.sender == i_owner, "not owner");
        x += 1;
    }
}
