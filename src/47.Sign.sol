// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/*
0. message to sign
1. hash(message)
2. sign(hash(message), private key) | offchain
3. ecrecover(hash(message), signature) == signer

=== 如何验证（以 personal_sign 为例）===

【前端签名示例】
  account = "0x6E3468Ce9bCc4F4e5106abf4821a62dB4d6A9e03"
  hash = "0x9c97d796ed69b7e69790ae723f51163056db3d55a7a6a82065780460162d4812"
  ethereum.request({ method: "personal_sign", params: [hash, account] })
  // 返回签名: "0x5618c0a65682f3fe001648864000b0db3f870d0c5810b0e46054c37792d4ebd4f006d3544d4bd07f7bed7a7a5992d1c1d6"

【两种验证方式】

1. 签的是原始消息（如 "hello"）：
   verify(signer, "hello", sig)
   合约内部会: hash("hello") -> 加 EIP-191 前缀 -> ecrecover

2. 签的是 hash（personal_sign 直接签 hash）：
   verifyWithHash(signer, hash, sig)
   合约内部会: 对 hash 加 EIP-191 前缀 -> ecrecover

【Remix 验证示例】
  signer: 0x6E3468Ce9bCc4F4e5106abf4821a62dB4d6A9e03
  hash:   0x9c97d796ed69b7e69790ae723f51163056db3d55a7a6a82065780460162d4812
  sig:    0x5618c0a65682f3fe001648864000b0db3f870d0c5810b0e46054c37792d4ebd4f006d3544d4bd07f7bed7a7a5992d1c1d6
  调用 verifyWithHash(signer, hash, sig) -> 应返回 true
*/

contract VerifySig {
    function verify(
        address _signer,
        string memory _message,
        bytes memory _sig
    ) external pure returns (bool) {
        bytes32 messageHash = getMessageHash(_message);
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);

        return recover(ethSignedMessageHash, _sig) == _signer;
    }

    // 当 personal_sign 直接签 hash 时使用
    function verifyWithHash(
        address _signer,
        bytes32 _messageHash,
        bytes memory _sig
    ) external pure returns (bool) {
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(_messageHash);
        return recover(ethSignedMessageHash, _sig) == _signer;
    }

    function getMessageHash(
        string memory _message
    ) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_message));
    }

    function getEthSignedMessageHash(
        bytes32 _messageHash
    ) public pure returns (bytes32) {
        return
            keccak256(
                abi.encodePacked(
                    "\x19Ethereum Signed Message:\n32",
                    _messageHash
                )
            );
    }

    function recover(
        bytes32 _ethSignedMessageHash,
        bytes memory _sig
    ) public pure returns (address) {
        (bytes32 r, bytes32 s, uint8 v) = _split(_sig);
        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    function _split(
        bytes memory _sig
    ) internal pure returns (bytes32 r, bytes32 s, uint8 v) {
        require(_sig.length == 65, "invalid signature length");

        assembly {
            r := mload(add(_sig, 32))
            s := mload(add(_sig, 64))
            v := byte(0, mload(add(_sig, 96)))
        }

        if (v < 27) v += 27; // web3.js 可能返回 0/1，ecrecover 需要 27/28
    }
}
