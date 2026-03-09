// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 特点： 1. 输入相同，输出一定相同 2. 输入不管有多大，输出是定长的 3.不可逆向运算
// 用途： 1. 用于签名运算 或 获取特定id

contract Hash {
    function hash(
        string memory _text,
        uint num,
        address addr
    ) external pure returns (bytes32) {
        return keccak256(abi.encode(_text, num, addr));
    }

    // abi.encode: 按 ABI 规范编码，每个参数固定长度 + padding，结果可 abi.decode 解码
    function encode(
        string memory test0,
        string memory test1
    ) external pure returns (bytes memory) {
        return abi.encode(test0, test1);
    }

    // abi.encodePacked: 紧凑编码，无 padding，直接拼接字节，输出更短
    // 注意：有碰撞风险，如 encodePacked("A","B") 与 encodePacked("AB") 结果相同
    function encodePacked(
        string memory test0,
        string memory test1
    ) external pure returns (bytes memory) {
        return abi.encodePacked(test0, test1);
    }

    // 演示 encodePacked 的碰撞：test0="A", test1="B" 与 test0="AB", test1="" 哈希相同
    function collision(
        string memory test0,
        string memory test1
    ) external pure returns (bytes32) {
        return keccak256(abi.encodePacked(test0, test1));
    }

    function collision2(
        string memory test0,
        uint num,
        string memory test1
    ) external pure returns (bytes32) {
        return keccak256(abi.encodePacked(test0, num, test1));
    }
}
