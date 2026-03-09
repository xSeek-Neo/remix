// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Enum {
    enum Status {
        None,
        Pending,
        Shipped,
        Completed,
        Rejected,
        Canceled
    }

    Status public status = Status.None;

    struct Order {
        address buyer;
        Status status;
    }

    Order public order;

    Order[] public orders;

    function get() external view returns (Status) {
        return status;
    }

    function set(Status _status) external {
        status = _status;
    }

    function ship() external {
        status = Status.Shipped;
    }

    function reset() external {
        delete status; // 删除状态变量 设置为默认值 Status.None 会释放 gas
    }
}
