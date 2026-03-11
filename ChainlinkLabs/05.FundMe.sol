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
    // 最小100USD

    mapping(address addr => uint256 amount) public fundersToAmount;
    uint256 private constant MIN_FUNDING_AMOUNT = 100 * 10 ** 18; // USD
    AggregatorV3Interface internal dataFeed;
    uint256 private constant TARGET = 1000 * 10 ** 18; // USD
    address public owner;

    uint256 deploymentTimestamp;
    uint256 lockTime;

    error SendFailed(
        bool success,
        address payable to,
        uint256 amount,
        string txt
    );

    constructor(uint256 _lockTime) {
        // spolia testnet
        dataFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        owner = msg.sender;
        deploymentTimestamp = block.timestamp;
        lockTime = _lockTime;
    }

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "This function is only be called by the owner"
        );
        _;
    }

    modifier windowClosed() {
        require(
            block.timestamp >= deploymentTimestamp + lockTime,
            "window is not closed"
        );
        _;
    }

    function fund() public payable {
        require(
            converEthToUsd(msg.value) >= MIN_FUNDING_AMOUNT,
            "Send more ETH"
        );
        require(
            block.timestamp < deploymentTimestamp + lockTime,
            "window is closed"
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

    function getFund() external windowClosed onlyOwner {
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
        // 返回值均为 (bool success, bytes memory returnData)，需检查 success 并处理 revert
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
        // 用法4：用 abi.encodeWithSelector 指定 selector（不转 ETH）
        //   (bool success, bytes memory data) = addr.call(
        //       abi.encodeWithSelector(SomeInterface.someFunction.selector, arg1, arg2)
        //   );
        //
        // 用法5：转 ETH + 用 selector 调用函数（如 DEX 用 ETH 换币）
        //   (bool success, bytes memory data) = payable(addr).call{value: amount}(
        //       abi.encodeWithSelector(IRouter.swapExactETHForTokens.selector, minOut, path, to, deadline)
        //   );

        bool success;
        (success, ) = payable(msg.sender).call{value: address(this).balance}(
            ""
        );
        require(success, "transfer failed");
        delete fundersToAmount[msg.sender];
    }

    function refund() external windowClosed {
        require(
            converEthToUsd(address(this).balance) < TARGET,
            "Target is reached, refund is not allowed"
        );
        require(fundersToAmount[msg.sender] != 0, "no funds to refund");

        (bool success, ) = payable(msg.sender).call{
            value: fundersToAmount[msg.sender]
        }("");
        require(success, "refund failed");
        delete fundersToAmount[msg.sender];
    }

    // 1:35
}
