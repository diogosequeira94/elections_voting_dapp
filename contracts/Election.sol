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

    /// Owner is who triggered the election
    function startElection(string memory _electionName) public {
        owner = msg.sender;
        electionName = _electionName;
    }

    modifier ownerOnly() {
        require(msg.sender == owner);
        _;
    }

    /// Only owner can addCandidates
    function addCandidate(string memory _candidateName) ownerOnly public {
        candidates.push(Candidate(_candidateName, 0));
    }

    function getCandidatesNumber() public view returns(uint){
        return candidates.length;
    }

    function authorizeVoter(address _voterAddress) ownerOnly public {
        voters[_voterAddress].isAuthorised = true;
    }

    function vote(uint candidateIndex) public {
        /// Needs to be authorized to vote
        require(voters[msg.sender].isAuthorised);
        /// Check if voter has not voted yet
        require(!voters[msg.sender].hasVoted);
        voters[msg.sender].candidateChosen = candidateIndex;
        voters[msg.sender].hasVoted = true;

        /// Increase candidate vote count by 1
        candidates[candidateIndex].votesNumber++;
    }

}