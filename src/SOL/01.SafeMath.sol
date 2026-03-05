/**
 * Solidity 8.0
 * safe math
 * custom errors
 * functions outside contract
 * import {symbol1 as alias, symbol2} from "filename"
 * Salted contract creations / create2
 */

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract SafeMath {
    function testUnderFlow() public pure returns (uint) {
        uint x = 0;
        x--;
        return x;
    }

    function testUncheckUnderFlow() public pure returns (uint) {
        uint x = 0;
        unchecked {
            x--;
        }
        return x;
    }
}
