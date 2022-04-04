// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract VulcanoCoin {

    uint supply;
    address owner;
    mapping(address => uint) public balances;

    event SupplyChange(uint);
    event TransferOccurence(address, uint);

    modifier onlyOwner {
        if(msg.sender == owner) {
            _;
        }
    }

    constructor () {
        supply = 10000;
        owner = msg.sender;
        balances[owner] = supply;
    }

    function getTotalSupply() public view returns (uint) {
        return supply;
    }

    function increaseTotalSupply() public onlyOwner {
        supply += 1000;
        emit SupplyChange(supply);
    }

    function getUsersSupply(address _user) public view returns (uint) {
        return balances[_user];
    }

    function transfer(uint _amount, address _recipient) public {
        require(balances[msg.sender] >= _amount, "Not enough funds available");
        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;

        emit TransferOccurence(_recipient, _amount);
    }
}