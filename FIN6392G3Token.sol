pragma solidity ^0.8.7;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenName is ERC20 {
    address public owner;
    uint256 public balance;

    event TransferReceived(address _from, uint _amount);
    event TransferSent(address _from, address _destAddr, uint _amount);

// Constructor mints initial supply to our Bank contract (we'll add as param when we deploy)
    constructor(uint256 initialSupply, address payable receiver) ERC20("BVJMToken", "BVJM") {
        _mint(receiver, initialSupply * 10 ** 18);
        owner = msg.sender;
    }
    
// Receives and stores ether payment
    receive() external payable {
        balance += msg.value;
        emit TransferReceived(msg.sender, msg.value);
    }

// Stores the ether through receive() and mints 5000 tokens per ether
    function exchange() public payable {
        (bool sent, bytes memory data) = address(this).call{value: msg.value}("");
        require(sent, "Failed to send Ether");
        _mint(msg.sender, msg.value * 5000);
    }


}
