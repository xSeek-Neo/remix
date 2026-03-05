// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Data Locations:  Storage 状态变量 , Memory 局部变量, Calldata 只读用在参数中 可以节省gas

contract DataLocations {
    struct MyStruct {
        uint foo;
        string text;
    }

    mapping(address => MyStruct) public myStructs;

    function example(
        uint[] calldata y,
        string calldata s
    ) external returns (uint[] memory) {
        myStructs[msg.sender] = MyStruct({foo: 123, text: "Bar"});

        MyStruct storage myStruct = myStructs[msg.sender];
        myStruct.text = "Foo";

        MyStruct memory readonly = myStructs[msg.sender];
        readonly.text = "Baz";

        _internal(y);

        uint[] memory memArr = new uint[](5);
        memArr[0] = 1;
        memArr[1] = 2;
        memArr[2] = 3;
        memArr[3] = 4;
        memArr[4] = 5;

        return memArr;
    }

    function _internal(uint[] calldata y) private {
        uint x = y[0];
    }
}
