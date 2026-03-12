// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// require revert  assert
// gas 退换, 状态回滚
// gas refund,  state update are reverted
// custom error save gas

contract Error {
    // 01.
    function testRequire(uint _i) public pure {
        require(_i <= 10, "i > 10");
        // more code
    }

    // 02.
    function testRevert(uint _i) public pure {
        if (_i > 10) {
            revert("i > 10");
        }
        // more code
    }

    // 03.
    uint public num = 123;
    function testAssert() public view {
        assert(num == 123);
        // more code
    }

    function update_num(uint _i) public {
        num += 1;
        require(_i < 10);
    }

    // 04. 自定义错误
    error MyError(address caller, uint i);

    function testCustomError(uint _i) public view {
        if (_i > 10) {
            revert MyError(msg.sender, _i);
        }
        // more code
    }
}
