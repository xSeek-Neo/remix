// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC721 {
    function transferFrom(address _from, address _to, uint _nftId) external;
}

// 荷兰拍卖
contract DutchAuction {
    uint private constant DURATION = 7 days;

    IERC721 public immutable nft;
    uint public immutable nftId;
    address payable public immutable seller;
    uint public immutable startingPrice;
    uint public immutable startAt;
    uint public immutable expiresAt;
    uint public immutable discountRate;

    constructor(
        uint _startingPrice,
        uint _discountRate,
        address _nft,
        uint _nftId
    ) {
        // 起拍价需 >= 折扣率 * 时长，否则拍卖期内价格会变为负数
        require(
            _startingPrice >= _discountRate * DURATION,
            "starting price < discount"
        );
        seller = payable(msg.sender); // 部署者为卖家，需 payable 以接收 ETH
        startingPrice = _startingPrice;
        discountRate = _discountRate;
        startAt = block.timestamp; // 拍卖开始时间
        expiresAt = block.timestamp + DURATION; // 拍卖结束时间（7 天后）
        nft = IERC721(_nft); // 将地址转为 IERC721 接口以调用 transferFrom
        nftId = _nftId;
    }

    function getPrice() public view returns (uint) {
        uint timeElapsed = block.timestamp - startAt;
        uint discount = discountRate * timeElapsed;
        return startingPrice - discount;
    }

    function buy() external payable {
        require(block.timestamp < expiresAt, "auction expired");
        uint price = getPrice();
        require(msg.value >= price, "ETH < price");
        nft.transferFrom(seller, msg.sender, nftId);
        uint refund = msg.value - price;
        if (refund > 0) {
            payable(msg.sender).transfer(refund);
        }
        selfdestruct(seller); // 销毁合约，剩余 ETH 全部转给卖家
    }
}
