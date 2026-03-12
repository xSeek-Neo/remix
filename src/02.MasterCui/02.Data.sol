// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Date Types:  Values and Reference

contract ValueTypes {
    bool public b = true;
    // 无符号正整数
    uint public u = 123; // uint = uint256, 范围 0 to 2**256 - 1;
    // uint8,  范围 0 to 2**8 - 1;
    // uint16, 范围 0 to 2**16 - 1;
    int public i = -123; // int = int256, 范围 0 to 2**255 - 1; 一般在正数 一半在负数
    int public minInt = type(int).min;
    int public maxInt = type(int).max;
    address public addr = 0x2cF5e36B1E46774D7c6618e67CD921fa614EfC21; // 这是一个16进制数字 通过公钥 和 私钥算出来
    bytes32 public b32 =
        hex"89c58ced8a9078bdef2bb66f22e58eef7f7dbf6ed6c2dff3e7c508b629295926";
    bytes public b33 =
        hex"89c58ced8a9078bdef2bb66f22e58eef7f7dbf6ed6c2dff3e7c508b629295926fa";
}
