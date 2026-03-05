// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract DefaultValues {
    bool public b; // false
    uint public u; // 0
    int public i; // 0
    // 160位 20字节，默认 0x0000000000000000000000000000000000000000（0x 后面40个字符0）
    // 换算：1 十六进制字符=4位，40字符=160位，160位÷8=20字节
    address public addr; 
    // 256位 32字节，默认 0x0000000000000000000000000000000000000000000000000000000000000000（0x 后面64个字符0）
    // 换算：1 十六进制字符=4位，64字符=256位，256位÷8=32字节
    bytes32 public b32;
}