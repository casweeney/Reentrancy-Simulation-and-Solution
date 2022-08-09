// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract GoodContract {
    /// @dev    mapping that holds user deposits
    mapping(address => uint) balances;


    /// @dev    function that enables users to deposit
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    /// @dev    function that enables users to withdraw
    function withdraw() public {
        require(balances[msg.sender] > 0, "Insufficient funds");

        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent, "Failed to send ether");

        balances[msg.sender] = 0;
    }

    /// @dev get contract balance
    function getBalance() external view returns (uint bal) {
        bal = address(this).balance;
    }
}

// To protect yourself against reentrancy

// 1. Use @openzeppelin non-reentrancy guard contract 
// or
// 2. Make sure you do all you checks and update balances before making enternal calls