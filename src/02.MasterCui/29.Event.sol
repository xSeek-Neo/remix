// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Event {
    // 记录当前智能合约状态的方法 并不会记录在状态变量中 只会在区块链浏览器 或者 log中
    event Log(string message, uint val);
    // up to 3 index 有索引的变量最多有三个
    event IndexedLog(address indexed sender, uint val);

    function example() external {
        emit Log("Log message", 123);
        emit IndexedLog(msg.sender, 789);
    }

    event Message(address indexed _from, address indexed  _to, string message);

    function sendMessage(address _to, string calldata message) external {
        emit Message(msg.sender, _to, message);
    }
}
