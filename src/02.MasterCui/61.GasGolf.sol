// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract GasGolf {
    // start - 50908 gas
    // use calldata - 49163 gas
    // load state variables to memory - 48952 gas
    // short circuit - 48634 gas
    // loop increments - 48226 gas
    // cache array length - 48191 gas
    // load array elements to memory - 48029 gas

    uint public total;

    // [1, 2, 3, 4, 5, 100]
    function sumIfEvenAndLessThan99(uint[] memory nums) external {
        for (uint i = 0; i < nums.length; i += 1) {
            bool isEven = nums[i] % 2 == 0;
            bool isLessThan99 = nums[i] < 99;
            if (isEven && isLessThan99) {
                total += nums[i];
            }
        }
    }

    // function sumIfEvenAndLessThan99(uint[] calldata nums) external {
    //     uint _total = total;
    //     uint len = nums.length;
    //     for (uint i = 0; i < len; ++i) {
    //         uint num = nums[i];
    //         if (num % 2 == 0 && num < 99) {
    //             _total += num;
    //         }
    //     }
    //     total = _total;
    // }
}
