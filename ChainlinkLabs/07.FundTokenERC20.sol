// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {FundMe} from "./05.FundMe.sol";

// Fundme
// 1. 让Fundme的参与者基于 mapping 来领取相应数量的通证
// 2. 让Fundme的参与者，transfer 通证
// 3. 在通证使用完成以后 需要burn 通证

contract FundTokenERC20 is ERC20 {
    FundMe fundMe;
    constructor(address fundMeAddr) ERC20("FundTokenERC20", "FT") {
        fundMe = FundMe(fundMeAddr); // 把这个地址 强制类型转换成 FundMe 合约接口引用（不是创建新合约）
    }

    function mint(uint256 amountToMint) public {
        require(
            fundMe.fundersToAmount(msg.sender) >= amountToMint,
            "You can't mint this many tokens"
        );
        require(fundMe.getFundSuccess(), "The fundme is not completed yet");
        _mint(msg.sender, amountToMint);
        fundMe.setFunderToAmount(
            msg.sender,
            fundMe.fundersToAmount(msg.sender) - amountToMint
        );
    }

    // transfer 使用父合约中transfer

    function claim(uint256 amountToClaim) public {
        // complete cliam
        require(
            balanceOf(msg.sender) >= amountToClaim,
            "You dont have enough ERC20 tokens"
        );
        require(fundMe.getFundSuccess(), "The fundme is not completed yet");
        /*to add */
        // burn amountToClaim Tokens
        _burn(msg.sender, amountToClaim);
    }

    // burn 使用父合约中burn

    // 3:03
}
