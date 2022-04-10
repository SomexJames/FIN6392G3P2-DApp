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
