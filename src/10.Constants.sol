// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Constants {
    // 常量 可以节约gas 命名规范： 大写、中间用_连接
    address public constant MY_ADDRESS =
        0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    uint public constant MY_UINT = 123;
}

contract Var {
    address public MY_ADDRESS = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    uint public constant MY_UINT = 123;
}
