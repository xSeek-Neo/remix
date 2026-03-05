// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 01.Array: dynamic or fixed size
// 02.Initialization

// Insert	arr.push(x) 或 arr.push()
// Get	arr[i]
// Update	arr[i] = value
// Delete	delete arr[i]（置为 0，不改变 length）
// Pop	arr.pop()
// Length	arr.length（可读写，可 arr.length = n）

// Creating arrays in memory
// Reutning Arrays from Functions

// 动态数组 uint[] API：length(可读写)、push()/push(x)、pop()、delete arr[i]、arr[i]
// 固定数组 uint[n] API：length(只读)、arr[i]、delete arr[i]、delete arr（整数组置默认值）
// 固定数组无 push/pop，length 不可赋值

contract Array {
    uint[] public nums = [1, 2, 3];
    uint[3] public numsFixed = [4, 5, 6];

    function example() external {
        nums.push(4); // [1, 2, 3, 4]
        nums[1]; // 2

        nums[2] = 777; // [1, 2, 777, 4]

        // delete 不会改变数组的长度 会把被删位置的值设置为默认值 0
        delete nums[1]; // [1, 0, 777, 4]
        nums.pop(); // [1, 0, 777]
        nums.length; // 3

        // create array in memory
        // 内存数组限制：创建时固定长度，不能 push/pop；length 只读；函数结束即销毁
        // 不支持 delete 整个数组；不能整体赋值（需逐元素复制）；大数组 gas 消耗高
        uint[] memory a = new uint[](5); // [0, 0, 0, 0, 0]
        a[0] = 1; // [1, 0, 0, 0, 0]
        a[1] = 2; // [1, 2, 0, 0, 0]
        a[2] = 3; // [1, 2, 3, 0, 0]
        a[3] = 4; // [1, 2, 3, 4, 0]
        a[4] = 5; // [1, 2, 3, 4, 5]
        // a.length; // 5
        // a[0]; // 1
    }

    // returning arrays from functions
    function returnArray() external view returns (uint[] memory) {
        return nums;
    }
}
