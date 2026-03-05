// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// state Variables
// global Variables
// function modifier
// function
// error handling

contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }

    function setOwner(address _newOwner) external onlyOwner {
        require(_newOwner != address(0), "invalid address");
        owner = _newOwner;
    }

    function onlyOwnerCanCallThisFunction() external onlyOwner {}

    function anyOwnerCanCall() external {}
}
