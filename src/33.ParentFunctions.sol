// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/*
调用父合约函数的 2 种方式：
- direct：直接指定合约名调用，如 E.foo()
- super：按 C3 线性化顺序调用上一级父合约

菱形继承结构：
  E
 / \
F   G
 \ /
  H
*/

contract E {
    event Log(string message);

    function foo() public virtual {
        emit Log("E.foo");
    }

    function bar() public virtual {
        emit Log("E.bar");
    }
}

// 方式一：direct - 直接调用指定父合约 E 的 foo
contract F is E {
    function foo() public virtual override {
        emit Log("F.foo");
        E.foo(); // direct：显式调用 E 的 foo
    }

    function bar() public virtual override {
        emit Log("F.bar");
        super.bar(); // super：调用上一级（即 E）的 bar
    }
}

// 方式一：direct - 直接调用 E.foo()
contract G is E {
    function foo() public virtual override {
        emit Log("G.foo");
        E.foo(); // direct
    }

    function bar() public virtual override {
        emit Log("G.bar");
        super.bar(); // super：调用 E.bar()
    }
}

// 菱形继承：H 继承 F 和 G，需 override(F, G) 指定多个父合约
contract H is F, G {
    function foo() public override(F, G) {
        F.foo(); // direct：只调用 F 的 foo（F 内部会再调 E.foo）
    }

    function bar() public override(F, G) {
        super.bar(); // super：按线性化顺序调用，即 F.bar() -> E.bar()
    }
}
