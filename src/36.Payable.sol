// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// payable: 函数/地址可接收 ETH

// deposit 可以没有函数体，空实现是合法的。
// payable 修饰符已经让函数能接收 ETH，调用时传入的 ETH 会自动加到合约余额，不需要在函数里写任何代码。
// 如果要额外逻辑，再在函数体里写，例如：记录存款、发事件等。
// 当前这种只接收 ETH 的写法是没问题的。

contract Payable {
    address payable public owner;

    event Deposited(address indexed sender, uint amount);

    constructor() {
        owner = payable(msg.sender);
    }

    function deposit() external payable {} // 空体即可，ETH 自动入账

    // 可选：带事件记录的存款
    function depositWithEvent() external payable {
        emit Deposited(msg.sender, msg.value);
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}
