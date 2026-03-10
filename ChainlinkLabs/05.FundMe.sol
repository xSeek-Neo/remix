// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {
    AggregatorV3Interface
} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    // 1.创建一个收款函数、
    // 2.记录投资人并查看
    // 3.在锁定期内, 达到目标值 生产商可以提款
    // 4.在锁定期内如果达到目标值 投资人可以在锁定器后退款

    AggregatorV3Interface internal dataFeed;

    constructor() {
        // spolia testnet
        dataFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
    }

    mapping(address addr => uint256 amount) public fundersToAmount;

    // 最小100USD
    uint256 private constant MIN_FUNDING_AMOUNT = 100 * 10 ** 18; // USD

    function fund() public payable {
        require(
            converEthToUsd(msg.value) >= MIN_FUNDING_AMOUNT,
            "Send more ETH"
        );
        fundersToAmount[msg.sender] = msg.value;
    }

    function getChainlinkDataFeedLatestAnswer() public view returns (int256) {
        // prettier-ignore
        (
      /* uint80 roundId */
      ,
      int256 answer,
      /*uint256 startedAt*/
      ,
      /*uint256 updatedAt*/
      ,
      /*uint80 answeredInRound*/
    ) = dataFeed.latestRoundData();
        return answer;
    }

    function converEthToUsd(uint256 ethAmount) internal view returns (uint256) {
        uint256 ethPrice = uint256(getChainlinkDataFeedLatestAnswer());
        // ethPrice
        return (ethAmount * ethPrice) / (10 ** 8);
    }
}
