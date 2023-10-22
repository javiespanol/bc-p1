// contracts/MyContract.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Test {
    uint public m = 0;
    using SafeMath for uint256;

    function suma(uint256 n) public {
        m = m.add(n);
    }

    function mult(uint256 n) public {
        m = m.mul(n);
    }
}