// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// struct 结构体
// array 数组
// mapping 映射

contract Hi {
    string strVar = "Hello, World!";

    struct Info {
        string phrase;
        uint256 id;
        address addr;
    }

    mapping(uint256 id => Info info) infoMapping;

    // Info[] infos;

    function sayHi(uint256 _id) external view returns (string memory) {
        // for (uint256 i = 0; i < infos.length; ++i) {
        //     if (infos[i].id == _id) {
        //         return addInfo(infos[i].phrase);
        //     }
        // }
        if (infoMapping[_id].addr == address(0x0)) {
            return addInfo(strVar);
        } else {
            return addInfo(infoMapping[_id].phrase);
        }
    }

    function setHi(string memory newString, uint256 _id) public {
        Info memory info = Info(newString, _id, msg.sender);
        // infos.push(info);
        infoMapping[_id] = info;
    }

    function addInfo(
        string memory _strVar
    ) internal pure returns (string memory) {
        return string.concat(_strVar, " From Frank's Contract");
    }

    //1. storage
    //2. memory
    //3. calldata
    //4. stack
    //5. codes
    //6. logs
}
