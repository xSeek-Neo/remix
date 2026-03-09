// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 3 ways to send ETH from a contract
// transfer - 2300 gas, reverts on failure
// send - 2300 gas, returns bool
// call - all gas (configurable), returns (bool, bytes)

// 合约发送主币的三种方式
// transfer - 固定 2300 gas，失败时 revert 回滚
// send - 固定 2300 gas，失败时返回 false
// call - 可转发全部或指定 gas，返回 (成功与否, 返回数据)

contract SendEther {
    constructor() payable {}

    receive() external payable {}

    function sendViaTransfer(address payable _to) external payable {
        _to.transfer(123);
    }

    function sendViaSend(address payable _to) external payable {
        bool sent = _to.send(123);
        require(sent, "send failed");
    }

    function sendViaCall(address payable _to) external payable {
        (bool success, ) = _to.call{value: 123}("");
        require(success, "call failed");
    }
}

contract EthReceiver {
    event Log(uint amount, uint gas);

    receive() external payable {
        emit Log(msg.value, gasleft());
    }
}
