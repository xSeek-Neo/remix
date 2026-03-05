// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ETHWallet {
    address payable public owner;
    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable {}

    function withdraw(uint _amount) external {
        require(msg.sender == owner, "caller isnot owner");
        payable(msg.sender).transfer(_amount);

        // (bool success, ) = msg.sender.call{value: _amount}("");
        // require(success, "Failed to send ETH");
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}
