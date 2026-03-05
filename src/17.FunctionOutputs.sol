// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// return multiple outputs
// named outputs
// destructuring assignment

contract FunctionOutputs {
    function returnMultiple() public pure returns (uint, bool) {
        return (1, true);
    }

    function named() public pure returns (uint x, bool b) {
        return (1, true);
    }

    function assigned() public pure returns (uint x, bool b) {
        // 同样可以返回 x b 的值
        x = 1;
        b = true;
    }

    function destructuringAssignments() public pure {
        (uint x, bool b) = returnMultiple();
        (, bool _b) = returnMultiple();
        (x, b) = named();
        (x, b) = assigned();
        require(x == 1 && b && _b, "demo");
    }
}
