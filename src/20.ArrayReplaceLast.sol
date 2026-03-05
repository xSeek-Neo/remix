// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// remove array element by shifting elements to left
// [1, 2, 3, 4, 5, 6] --> remove(2) --> [1, 2, 4, 5, 6, 6] --> [1, 2, 4, 5, 6] 如果数组比较长 比较浪费gas

contract ArrayReplaceLast {
    uint[] public arr;
    // [1, 2, 3, 4] --> remove(1) --> [1, 4, 3]
    // [1, 4, 3]    --> remove(2) --> [1, 4]

    function remove(uint _idx) external {
        arr[_idx] = arr[arr.length - 1];
        arr.pop();
    }

    function test() external {
        arr = [1, 2, 3, 4];
        this.remove(1); // [1, 4, 3]

        assert(arr.length == 3);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
        assert(arr[2] == 3);

        this.remove(2);
        assert(arr.length == 2);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
    }
}
