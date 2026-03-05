// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

function helper(uint x) pure returns (uint) {
    return x * 2;
}

contract TestHelper {
    function test() external pure returns (uint) {
        return helper(123);
    }
}
