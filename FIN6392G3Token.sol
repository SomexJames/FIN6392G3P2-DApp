pragma solidity ^0.8.7;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";



contract G3Token is ERC20 {
    
    Bank public bank;
    address public owner;
    uint256 public etherBalance;

    event TransferReceived(address _from, uint _amount);
    event TransferSent(address _from, address _destAddr, uint _amount);

// Constructor mints initial supply to our Bank contract (we'll add as param when we deploy)
    constructor(uint256 initialSupply) ERC20("BVJMToken", "BVJM") {
        bank = new Bank();
        _mint(payable(address(bank)), initialSupply * 10 ** 18);
        owner = msg.sender;
    }
    
// Receives and stores ether payment
    receive() external payable {
        etherBalance += msg.value;
        emit TransferReceived(msg.sender, msg.value);
    }

// Stores the ether through receive()
    function exchange() external payable {
        (bool sent, bytes memory data) = address(this).call{value: msg.value}("");
        require(sent, "Failed to send Ether");
        bank.payout(ERC20(address(this)), msg.value * 5000, payable(msg.sender));
    }

    function sendPayout() public payable {
        bank.payout(ERC20(address(this)), msg.value, payable(msg.sender));
    }


}


contract Bank{
    address public owner;
    uint public tokenBalance;

    event TransferReceived(address _from, uint _amount);
    event TransferSent(address _from, address _destAddr, uint _amount);

    constructor() {
        owner = msg.sender;
    }
    
    receive() external payable {
        tokenBalance += msg.value;
        emit TransferReceived(msg.sender, msg.value);
    }

    function payout(ERC20 token, uint amount, address payable to) public {
        uint256 erc20balance = token.balanceOf(address(this));
        require(amount <= erc20balance, "Balance is too low");
        token.transfer(to, amount);
        emit TransferSent(msg.sender, to, amount);
    }

}
