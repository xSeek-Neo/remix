// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @notice 根据函数签名字符串计算 4 字节选择器
contract FunctionSelector {
    /// @dev 步骤：bytes() 转字节 → keccak256 哈希 → 取前 4 字节
    /// @param _func 函数签名，如 "transfer(address,uint256)"
    /// @return 4 字节选择器，如 0xa9059cbb
    function getSelector(string calldata _func) external pure returns (bytes4) {
        return bytes4(keccak256(bytes(_func)));
    }
}

/// @notice 演示 msg.data 的完整结构
contract Receiver {
    event Log(bytes data);

    /// @dev msg.data 结构：4 字节选择器 + 32 字节参数1 + 32 字节参数2 + ...
    /// 示例：transfer(0x5b38..., 11) 的 msg.data 为：
    /// - 0xa9059cbb (transfer 选择器)
    /// - 0000...5b38da6a701c568545dcfcb03fcb875f56beddc4 (地址，左补零到 32 字节)
    /// - 0000...0000000b (数值 11，左补零到 32 字节)
    function transfer(address /* _to */, uint /* _amount */) external {
        emit Log(msg.data);
    }
}
