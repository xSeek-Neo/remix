// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Mapping 映射
// how to declare a mapping (simple and nested)
// Set, Get, Delete

// ["alice", "bob", "charlie"]
// { "alice": true, "bob": true, "charlie": true }

contract Mapping {
    mapping(address => uint) public balances;
    mapping(address => mapping(address => bool)) public isFriend;

    function example() external  {
        balances[msg.sender] = 123;
        uint bal = balances[msg.sender];
        uint bal2 = balances[address(1)];

        balances[msg.sender] += 456;

        delete balances[msg.sender];

        bool isTrue = isFriend[msg.sender][address(this)];
    }
}
