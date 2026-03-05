// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


// contract FunctionModifier {
//     bool public paused;
//     uint public count;

//     function setPaused(bool _paused) external  {
//         paused = _paused;
//     }

//     function inc() external {
//         require(!paused, "paused");
//         count+=1;
//     }

//     function dec() external {
//         require(!paused, "paused");
//         count-=1;
//     }
// }

// Function Modifier - reuse code before and / or after funtion
// Basic, Inputs, Sandwich

contract FunctionModifier {
    bool public paused;
    uint public count;

    function setPaused(bool _paused) external {
        paused = _paused;
    }
    // 01.不带参数
    modifier whenNotPaused() {
        // 函数修改器
        require(!paused, "paused");
        _; // 函数的其他代码放在哪里运行
    }

    function inc() external whenNotPaused {
        count += 1;
    }

    function dec() external whenNotPaused {
        count -= 1;
    }

    // 02.带参数
    modifier cap(uint _x) {
        require(_x <= 100, "x > 100");
        _;
    }

    // 先运行 whenNotPaused 判断是否被暂停, 如果没有被暂停 运行cap把_x 传入 判断是否小于 100 如果小于 在执行 count+= _x;
    function incBy(uint _x) external whenNotPaused cap(_x) {
        count += _x; 
    }

    modifier sandwich() {
        // code here
        count += 10;
        _;
        // more code here
        count *= 2;
    } 

    function test() external sandwich {
        count += 1;
    }

}
