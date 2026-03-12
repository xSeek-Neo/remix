// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract IfElse {
    // if else 语句
    function example(int _x) external pure returns (uint) {
        if (_x < 10) {
            return 1;
        } else if (_x < 20) {
            return 2;
        } else {
            // else 可以省略 但是不建议省略
            return 3;
        }
    }

    function ternary(int _x) external pure returns (uint) {
        // if (_x < 10) {
        //     return 1;
        // }
        // return 2;
        return _x < 10 ? 1 : 2;
    }
}
