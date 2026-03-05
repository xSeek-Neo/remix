// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ForAndWhileLoops {
    // for 循环
    function Loops() external pure {
        for (uint i = 0; i < 10; i++) {
            if (i == 3) {
                // continue 跳过本次循环 more code 不会被执行
                continue;
            }
            // more code
            if (i == 5) {
                // 彻底 break 跳出循环 后面的循环不会执行了
                break;
            }
        }

        uint x = 0;
        while (x < 10) {
            x++;
        }
    }

    // for 循环 只能合约中 _n 不能太大 浪费gas
    function sum(uint _n) external pure returns (uint) {
        uint s = 0;
        for (uint i = 0; i < _n; i++) {
            s += i;
        }
        return s;
    }
}
