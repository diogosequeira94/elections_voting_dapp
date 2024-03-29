//SPDX_Licence-Identifier: UNLICENSED
pragma experimental ABIEncoderV2;
pragma solidity >=0.4.22 <0.9.0;

contract Election {

    struct Candidate {
        string id;
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
    string public electionName;

    mapping(address => Voter) public voters;
    Candidate[] public candidates;
    uint public totalVotes;

    /// Owner is has triggered the election
    function startElection(string memory _electionName) public {
        delete candidates;
        owner = msg.sender;
        electionName = _electionName;
    }

    modifier ownerOnly() {
        require(msg.sender == owner);
        _;
    }

    /// Only owner can addCandidates
    function addCandidate(string memory _id, string memory _candidateName, string memory _party) ownerOnly public {
        candidates.push(Candidate(_id, _candidateName, _party, 0));
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
        require(!voters[msg.sender].hasVoted);
        voters[msg.sender].candidateChosen = candidateIndex;
        voters[msg.sender].hasVoted = true;

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
