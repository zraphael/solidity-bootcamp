// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0; // That's nice to be fixed when building for production

contract Score {

uint score;
address admin;
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

}