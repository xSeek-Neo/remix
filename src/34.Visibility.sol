// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// visibility 可见性
// private - only inside contract | 仅当前合约内部可访问
// internal - only inside contract and child contracts | 当前合约及子合约可访问
// public - inside and outside contract | 当前合约/子合约/外部合约 均可访问（自动生成 getter）
// external - only from outside contract | 仅外部可访问（内部需用 this.func() 调用）

// 默认值 default: 函数无默认必须显式指定 | 状态变量默认为 internal

/*
  ｜ A                         ｜
  ｜ private pri()             ｜
  ｜ internal inter()          ｜  <---------- C (外部调用)
  ｜ public pub()              ｜  pub() and ext()
  ｜ external ext()            ｜

  ｜ B is A                    ｜
  ｜ inter()  (继承自 A)        ｜  <---------- C (外部调用)
  ｜ pub()    (继承自 A)        ｜  pub() and ext()
*/

contract A {
    function pri() private pure returns (string memory) {
        return "private";
    }

    function inter() internal pure returns (string memory) {
        return "internal";
    }

    function pub() public pure returns (string memory) {
        return "public";
    }

    function ext() external pure returns (string memory) {
        return "external";
    }

    function test() public view returns (string memory) {
        pri(); // private: 内部可调
        inter(); // internal: 内部可调
        pub(); // public: 内部可调
        return this.ext(); // external: 内部需用 this. 调用
    }
}

contract B is A {
    function testB() public pure returns (string memory) {
        inter(); // internal: 子合约可调
        return pub(); // public: 子合约可调
        // pri();  // private: 不可访问
        // ext();  // external: 内部不可直接调，需 this.ext()
    }
}

contract VisibilityBase {
    uint private x = 0;
    uint internal y = 1;
    uint public z = 2;

    function privateFunc() private pure returns (uint) {
        return 0;
    }

    function internalFunc() internal pure returns (uint) {
        return 100;
    }

    function publicFunc() public pure returns (uint) {
        return 200;
    }

    function externalFunc() external pure returns (uint) {
        return 300;
    }

    function examples() external view {
        x + y + z;
        privateFunc();
        internalFunc();
        publicFunc();
        this.externalFunc(); // 不建议这么使用 浪费gas
    }
}

contract VisibilityChild is VisibilityBase {
    function examples2() external view {
        y + z;
        internalFunc();
        publicFunc();
        this.externalFunc(); // 不建议这么使用 浪费gas
    }

    // 外部函数也不被子合约重写
}
