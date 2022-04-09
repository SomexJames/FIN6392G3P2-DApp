// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Bank {
    address public owner;

    event TransferReceived(address _from, uint _amount);

    constructor() {
        owner = msg.sender;
    }
    
    receive() external payable {
        emit TransferReceived(msg.sender, msg.value);
    }

}
