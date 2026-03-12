// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 调用父合约构造函数的 2 种方式
// 初始化顺序：从左到右，从基类到派生类

contract S {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

contract T {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

// 方式一：继承时直接传入固定参数
contract U is S("s"), T("t") {}

// 方式二：继承时传入动态参数，在构造函数中调用父构造函数
contract V is S, T {
    constructor(string memory _name, string memory _text) S(_name) T(_text) {}
}

// 混合：S 用固定值，T 用动态参数
contract VV is S("s"), T {
    constructor(string memory _text) T(_text) {}
}

// 混合：S 用动态参数，T 用固定值
contract VVV is S, T("t") {
    constructor(string memory _name) S(_name) {}
}

// 执行顺序：1.S -> 2.T -> 3.V0（由继承顺序决定，与构造函数中书写顺序无关）
contract V0 is S, T {
    constructor(string memory _name, string memory _text) S(_name) T(_text) {}
}

// 执行顺序：1.S -> 2.T -> 3.V1（同上，即使写成 T(_text) S(_name) 也先执行 S）
contract V1 is S, T {
    constructor(string memory _name, string memory _text) T(_text) S(_name) {}
}
