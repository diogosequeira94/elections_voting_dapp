//SPDX_Licence-Identifier: UNLICENSED
pragma solidity >=0.4.22 <0.9.0;

contract Election {

    struct Candidate {
        string name;
        uint votesNumber;
    }

    struct Voter {
        string name;
        uint candidateChosen;
        bool isAuthorised;
        bool hasVoted;
    }

    address public owner;
    string public electionName;

    mapping(address => Voter) public voters;
    Candidate[] public candidates;
    uint public totalVotes;


    function startElection(){

    }
}
