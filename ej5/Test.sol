// contracts/MyContract.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Base64.sol";

contract Test {

    function convert(string memory _str) pure  public returns (string memory){
        return Base64.encode(bytes(_str));
    }

}