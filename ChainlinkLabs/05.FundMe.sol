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

    address public owner;
    AggregatorV3Interface internal dataFeed;

    error SendFailed(
        bool success,
        address payable to,
        uint256 amount,
        string txt
    );

    constructor() {
        // spolia testnet
        dataFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        owner = msg.sender;
    }

    mapping(address addr => uint256 amount) public fundersToAmount;

    // 最小100USD
    uint256 private constant MIN_FUNDING_AMOUNT = 100 * 10 ** 18; // USD
    uint256 private constant TARGET = 1000 * 10 ** 18; // USD

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "This function is only be called by the owner"
        );
        _;
    }

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

    function transferOwnerShip(address _newOwner) public onlyOwner {
        owner = _newOwner;
    }

    function getFund() external onlyOwner {
        require(
            converEthToUsd(address(this).balance) >= TARGET,
            "Target not reached"
        );

        //01. transfer: 已经被遗弃 transfer ETH and revert tx failed 使用: addr.transfer(amount)
        // payable(msg.sender).transfer(address(this).balance);
        //02. send: 已经被遗弃 transfer ETH and return bool 使用: addr.send(amount)
        // bool success = payable(msg.sender).send(address(this).balance);
        // if (!success) {
        //     revert SendFailed(
        //         success,
        //         payable(msg.sender),
        //         address(this).balance,
        //         "tx failed"
        //     );
        // }
        // ========== call 的几种用法 ==========
        // call 是底层调用，可转 ETH、传数据、接收返回值，推荐用于转账（不固定 2300 gas）
        //
        // 用法1：只转 ETH，不附带数据（当前用法）
        //   (bool success, ) = payable(addr).call{value: amount}("");
        //
        // 用法2：转 ETH + 调用目标合约函数（带 calldata）
        //   (bool success, bytes memory data) = payable(addr).call{value: amount}(
        //       abi.encodeWithSignature("deposit()")
        //   );
        //
        // 用法3：不转 ETH，只调用函数
        //   (bool success, bytes memory data) = addr.call(
        //       abi.encodeWithSignature("foo(uint256)", 123)
        //   );
        //
        // 用法4：用 abi.encodeWithSelector 指定 selector
        //   (bool success, bytes memory data) = addr.call(
        //       abi.encodeWithSelector(SomeInterface.someFunction.selector, arg1, arg2)
        //   );
        //
        // 返回值：(bool success, bytes memory returnData)，需检查 success 并处理 revert
        bool success;
        (success, ) = payable(msg.sender).call{value: address(this).balance}(
            ""
        );
    }
}
