// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import '@openzeppelin/contracts/security/ReentrancyGuard.sol';

contract ProtectedWithReentrant is ReentrancyGuard {

    constructor() ReentrancyGuard() {}

    /// @dev    mapping that holds user deposits
    mapping(address => uint) balances;


    /// @dev    function that enables users to deposit
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    /// @dev    function that enables users to withdraw
    function withdraw() nonReentrant() public {
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