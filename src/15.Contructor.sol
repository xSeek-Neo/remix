// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 合约的构造函数
contract Constructor {
  // 合约被部署的时候调用一次  用于初始化变量

  address public owner;
  uint public  x;

  constructor(uint _x) {
    owner = msg.sender;
    x = _x;
  } 
}
