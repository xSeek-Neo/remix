// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract D {
    uint public value;
    constructor(uint _arg) {
        value = _arg;
    }
}

// 1.调用getBytes32函数 传入参数123 output: 0x000000000000000000000000000000000000000000000000000000000000007b
// 2.调用getAddress 传入 0x000000000000000000000000000000000000000000000000000000000000007b, 777 
// output: 0x2cF5e36B1E46774D7c6618e67CD921fa614EfC21
// 3. createDSalted(0x000000000000000000000000000000000000000000000000000000000000007b, 777)
// 4. 调用deployedAddr() 0x2cF5e36B1E46774D7c6618e67CD921fa614EfC21

contract Create2 {
    address public deployedAddr;

    /// @notice 将 uint 转为 bytes32（CREATE2 的 salt）
    function getBytes32(uint salt) external pure returns (bytes32) {
        return bytes32(salt);
    }

    /// @notice 预测使用 CREATE2 部署 D 合约的地址
    /// @param salt CREATE2 盐值
    /// @param arg 传入 D 构造函数的参数
    function getAddress(bytes32 salt, uint arg) external view returns (address) {
        address addr = address(uint160(uint(keccak256(abi.encodePacked(
            bytes1(0xff),
            address(this),
            salt,
            keccak256(abi.encodePacked(
                type(D).creationCode,
                arg
            ))
        )))));
        return addr;
    }

    /// @notice 使用 CREATE2 部署 D 合约
    /// @param salt CREATE2 盐值
    /// @param arg 传入 D 构造函数的参数
    function createDSalted(bytes32 salt, uint arg) public {
        D d = new D{salt: salt}(arg);
        deployedAddr = address(d);
    }
}
