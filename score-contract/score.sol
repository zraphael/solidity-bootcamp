// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0; // That's nice to be fixed when building for production

contract Score {

    uint score;
    address admin;
    mapping(address => uint) public score_list;
    event ScoreSet(uint);

    modifier onlyAdmin {
        if (msg.sender == admin) {
            _;
        }
    }

    constructor () {
        score = 5;
        admin = msg.sender;
    }

    function getScore() public view returns (uint) {
        return score;
    }

    function setScore(uint _newScore) public onlyAdmin {
        score = _newScore;
        emit ScoreSet(score);
    }

    function setUserScore(address _user, uint _newScore) public onlyAdmin {
        score_list[_user] = _newScore;
    }

    function getUserScore(address user) public view returns (uint) {
        return score_list[user];
    }

}