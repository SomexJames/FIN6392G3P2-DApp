pragma solidity >=0.7.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenName is ERC20 {
    constructor() ERC20("TokenName", "SYMBOL") {
        _mint(msg.sender, 10000000 * 10 ** 18);
    }
}
