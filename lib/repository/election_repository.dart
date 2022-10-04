import 'package:elections_dapp/models/candidate.dart';
import 'package:elections_dapp/repository/election_web3_api_client.dart';
import 'package:elections_dapp/repository/endpoints.dart';
import 'package:web3dart/web3dart.dart';

/// Election Repository
/// Responsible for CRUD operations and Error handling
class ElectionRepository {
  final ElectionWeb3Client _electionWeb3ApiClient = ElectionWeb3Client();

  static final _instance = ElectionRepository._internal();

  static ElectionRepository get instance => _instance;

  ElectionRepository._internal() {
    _electionWeb3ApiClient.init();
  }

  /// Generic callFunction
  /// Takes [functionName] defined in contract,
  /// [privateKey] from owner/voter
  /// and a List of [args] that will be used as params
  ///
  /// Other way should be splitting in several operations
  Future<String> callFunction(String functionName, String privateKey, List<dynamic> args) async {
    final credentials = EthPrivateKey.fromHex(privateKey);
    final contract = _electionWeb3ApiClient.getDeployedContract;
    final function = contract.function(functionName);

    return await _electionWeb3ApiClient.ethWeb3client.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: function,
        parameters: args,
      ),
      chainId: null,
      fetchChainIdFromNetworkId: true,
    );
  }

  Future<String> startElection(String name) async {
    final response = await callFunction('startElection', Endpoints.ownerPrivateKey(), [name]);
    print('Election started successfully');
    return response;
  }

  Future<String> addCandidate(String candidateName) async {
    final response = await callFunction('addCandidate', Endpoints.ownerPrivateKey(), [candidateName]);
    print('Candidate added successfully');
    return response;
  }

  Future<String> authorizeVoter(String address) async {
    final response =
        await callFunction('authorizeVoter', Endpoints.ownerPrivateKey(), [EthereumAddress.fromHex(address)]);
    print('Voter successfully authorized');
    return response;
  }

  /// Fix
  Future<List> getCandidates() async {
    final candidatesList = await callFunction('getCandidatesNumber', Endpoints.ownerPrivateKey(), []);
    return candidatesList as List;
  }

  /// Fix
  Future<Candidate> getCandidateInfo(int index) async {
    print('Getting candidate info....');
    final candidateInfo = await callFunction('getCandidatesNumber', Endpoints.ownerPrivateKey(), [BigInt.from(index)]);
    return candidateInfo as Candidate;
  }

  Future<String> getTotalVotes() async {
    final voteCount = await callFunction('getTotalVotes', Endpoints.ownerPrivateKey(), []);
    return voteCount;
  }

  Future<String> vote(int candidateIndex) async {
    final response = await callFunction('vote', Endpoints.voterPrivateKey(), [BigInt.from(candidateIndex)]);
    print('Vote counted successfully');
    return response;
  }
}
