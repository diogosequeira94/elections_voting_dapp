//SPDX_Licence-Identifier: UNLICENSED
pragma experimental ABIEncoderV2;
pragma solidity >=0.4.22 <0.9.0;

contract Election {

    struct Election {
        string id;
        string name;
        string creatorAddress;
    }

    struct Candidate {
        string name;
        string party;
        uint votesNumber;
    }

    struct Voter {
        string name;
        uint candidateChosen;
        bool isAuthorised;
        bool hasVoted;
    }

    address public owner;

    mapping(address => Voter) public voters;
    Candidate[] public candidates;
    Election[] public elections;
    uint public totalVotes;

    /// Owner is who triggered the election
    function startElection(string memory _id, string memory _name, string memory creatorAddress) public {
        owner = msg.sender;
        elections.push(Election(_id, _name, _creatorAddress));
    }

    modifier ownerOnly() {
        require(msg.sender == owner);
        _;
    }

    /// Only owner can addCandidates
    function addCandidate(string memory _candidateName, string memory _party) ownerOnly public {
        candidates.push(Candidate(_candidateName, _party, 0));
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

    function getCandidateInfo(uint index) public view returns(Candidate memory){
        return candidates[index];
    }

    function getTotalVotes() public view returns(uint){
        return totalVotes;
    }

    function getAlLCandidates() public view returns(Candidate[] memory){
        return candidates;
    }
}
