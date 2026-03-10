// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 工厂合约
// 1.用于创建同一合约的多个实例 并且正在寻找一种跟踪他们并简化管理的方法
// 2.节省部署成本：你可以先部署工厂合约 之后再使用时再部署其他合约
// 3. 提高合约的安全性

import {Hi as HiContract} from "./03.Struct.sol";
// import
// 1.相对路径引入本地文件
// 2.引入在线的合约地址 比如GitHub
// 3.三方库安装并引入

contract FactoryHi {
    HiContract hw;
    HiContract[] hws;
    function createHi() public {
        hw = new HiContract();
        hws.push(hw);
    }

    function getHwByIndex(uint256 _idx) external view returns (HiContract) {
        return hws[_idx];
    }

    function callSayHiFromFactory(
        uint256 _idx,
        uint256 _id
    ) external view returns (string memory) {
        return hws[_idx].sayHi(_id);
    }

    function callSetHiFromFactory(
        uint256 _idx,
        string memory newString,
        uint256 _id
    ) public {
        hws[_idx].setHi(newString, _id);
    }
}
