// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface ICounter {
    function inc() external;
    function dec() external;
    function count() external view returns (uint);
}

contract CallInterface {
    uint public count;

    function test(ICounter _counter) external {
        // _counter.inc();
        _counter.dec();
        count = _counter.count();
    }

    function example(address _counter) external {
        ICounter(_counter).inc();
        // ICounter(_counter).dec();
        count = ICounter(_counter).count();
    }
}
