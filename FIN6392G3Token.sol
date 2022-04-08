pragma solidity ^0.8.7;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenName is ERC20 {
    address public owner;
    uint256 public balance;

    event TransferReceived(address _from, uint _amount);

    constructor(uint256 initialSupply) ERC20("BVJMToken", "BVJM") {
        _mint(address(this), initialSupply * 10 ** 18);
        owner = msg.sender;
    }
    
    receive() external payable {
        balance += msg.value;
        emit TransferReceived(msg.sender, msg.value);
    }

    function exchange() public payable {
        (bool sent, bytes memory data) = address(this).call{value: msg.value}("");
        require(sent, "Failed to send Ether");
        _mint(msg.sender, msg.value * 500);
    }

    function deposit(uint256 amount, TokenName token) public payable {
        token.transferFrom(msg.sender, address(this), amount);
    }

}
