// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

// import "https://github.com/OpenZeppelin/openzeppelincontracts/blob/master/contracts/access/Ownable.sol";
// import "https://github.com/OpenZeppelin/openzeppelincontracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract VolcanoCoin is ERC20, Ownable {
    uint256 private constant INITIAL_SUPPLY = 10000;

    struct Payment {
        uint256 amount;
        address recipient;
    }

    mapping(address => Payment[]) public payments;
    event SupplyChanged(uint256 addedSupply);

    constructor() ERC20("Volcano Coin", "VLC") {
        _mint(msg.sender, INITIAL_SUPPLY);
    }

    function transfer(address _recipient, uint256 _amount)
        public
        override
        returns (bool)
    {
        _transfer(msg.sender, _recipient, _amount);
        recordPayment(msg.sender, _recipient, _amount);
        return true;
    }

    function recordPayment(
        address _sender,
        address _recipient,
        uint256 _amount
    ) internal {
        payments[_sender].push(Payment(_amount, _recipient));
    }

    function addToTotalSupply(uint256 _quantity) public onlyOwner {
        _mint(msg.sender, _quantity);
        emit SupplyChanged(_quantity);
    }

    function getPayments(address _user) public view returns (Payment[] memory) {
        return payments[_user];
    }
}