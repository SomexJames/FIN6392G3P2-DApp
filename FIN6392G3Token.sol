pragma solidity >=0.7.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenName is ERC20 {
    constructor() ERC20("TokenName", "SYMBOL") {
        _mint(msg.sender, 10000000 * 10 ** 18);
    }
}

contract FeeCollector  {
    address public owner;
    uint256 public balance;
    
    event TransferReceived(address _from, uint _amount);
    event TransferSent(address _from, address _destAddr, uint _amount);
    
    constructor() {
        owner = msg.sender;
    }
    
    receive() payable external {
        balance += msg.value;
        emit TransferReceived(msg.sender, msg.value);
    }    
    
// wrote this withdraw function in case we need it. Commented out for now
//   function withdraw(uint amount, address payable destAddr) public {
//         require(msg.sender == owner, "Only owner can withdraw funds"); 
//         require(amount <= balance, "Insufficient funds");
        
//         destAddr.transfer(amount);
//         balance -= amount;
//         emit TransferSent(msg.sender, destAddr, amount);
//     }
    
//main transfer function
    function transferERC20(TokenName token, address to, uint256 amount) public {
        //
        require(msg.sender == owner, "Only owner can withdraw funds"); //msg.sender refers to the address where the contract is being called from.
        uint256 erc20balance = token.balanceOf(address(this)); //address(this) refers to the address of the instance of the contract where the call is being made. Therefore, address(this) and msg.sender are two unique addresses, the first referring to the address of the contract instance and the second referring to the address where the contract call originated from.
        require(amount <= erc20balance, "balance is low"); //require that we have sufficient funds
        token.transfer(to, amount);
        emit TransferSent(msg.sender, to, amount);
    }    
}
