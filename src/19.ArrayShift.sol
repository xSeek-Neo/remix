// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ArrayShift {
    uint[] public arr;

    function example() public {
        arr = [1, 2, 3];
        delete arr[1]; // [1, 0, 3] 删除指定下标的元素 会把指定下标位置元素设置成默认值 不会改变数组的长度 和 ts 有差异
    }

    // 删除数组中元素的方法
    // [1, 2, 3] --> remove(1) --> [1, 3, 3] --> [1, 3]
    // [1, 2, 3, 4, 5, 6] --> remove(2) --> [1, 2, 4, 5, 6, 6] --> [1, 2, 4, 5, 6]
    // [1] --> remove(0) --> [1] --> []
    function remove(uint _index) public {
        // _index 必须小于数组的长度
        require(_index < arr.length, "index out of bound");

        for (uint i = _index; i < arr.length - 1; i++) {
            arr[i] = arr[i + 1];
        }
        arr.pop();
    }

    function test() external {
        arr = [1, 2, 3, 4, 5];
        remove(2); // [1, 2, 4, 5]

        assert(arr[0] == 1);
        assert(arr[1] == 2);
        assert(arr[2] == 4);
        assert(arr[3] == 5);
        assert(arr.length == 4);

        arr = [1];
        remove(0); // []
        assert(arr.length == 0);
    }
}
