// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Hi {
    bool boolVar_1 = true;
    bool boolVar_2 = false;
    // unsinged integer
    uint8 uintVar = 255;
    uint256 uint256Var = 25555555; // 0 - (2^256 - 1)

    int256 int256Var = -1;

    bytes32 byteVar = "Hello world";

    // bytes byte[] 是个数组

    string strVar = "Hello world"; // string 其实是一个bytes的数组

    address addr = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
}

// struct mapping array
