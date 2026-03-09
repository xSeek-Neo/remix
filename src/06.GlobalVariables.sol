// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract GlobalVariables {
    // 不用定义就能显示内容的变量 这些变量记录了链上的信息 和 账户的信息

    // view 可以读取状态变量 和 全局变量
    // pure 不能读取变量
    function globalVars() external view returns (address, uint, uint) {
         address sender = msg.sender; // 上一个调用函数的地址 1.可能是一个用户 2.可能是调用这个合约(GlobalVariables) 的一个合约
         uint timestamp = block.timestamp; // 是当前区块被打包时的时间戳
         uint blockNumber = block.number; // 是当前区块的编号
        //  uint blockDifficulty = block.difficulty; // 是当前区块的难度
        //  uint blockGasLimit = block.gaslimit; // 是当前区块的gas限制
        //  uint blockGasPrice = block.gasprice; // 是当前区块的gas价格
        //  uint blockGasUsed = block.gasused; // 是当前区块的gas使用量
        //  uint blockGasLeft = block.gasleft; // 是当前区块的gas剩余量
       return (sender, timestamp, blockNumber);
    }
}