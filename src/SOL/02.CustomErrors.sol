// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract VendingMachine {
    address payable owner = payable(msg.sender);
    error Unauthorized(address caller);

    function withdraw() public {
        if (msg.sender != owner) {
            // 2628 gas
            // revert("error error error error error error error error");
            revert Unauthorized(msg.sender);
        }
        owner.transfer(address(this).balance);
    }
}
