// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Hi {
    string strVar = "Hello, World!";

    function sayHi() external view returns (string memory) {
        return addInfo();
    }

    function setHi(string memory newString) public {
        strVar = newString;
    }

    function addInfo() internal view returns(string memory) {
        return string.concat(strVar, " From Frank's Contract");
    }

    //1. storage 
    //2. memory
    //3. calldata
    //4. stack
    //5. codes
    //6. logs
}

