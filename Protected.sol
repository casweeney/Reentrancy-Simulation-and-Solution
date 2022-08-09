// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ProtectedContract {
    /// @dev    mapping that holds user deposits
    mapping(address => uint) balances;


    /// @dev    function that enables users to deposit
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    /// @dev    function that enables users to withdraw
    function withdraw() public {
        require(balances[msg.sender] > 0, "Insufficient funds");

        uint userBalance = balances[msg.sender];
        balances[msg.sender] = 0;

        (bool sent, ) = msg.sender.call{value: userBalance}("");
        require(sent, "Failed to send ether");
    }

    /// @dev get contract balance
    function getBalance() external view returns (uint bal) {
        bal = address(this).balance;
    }
}