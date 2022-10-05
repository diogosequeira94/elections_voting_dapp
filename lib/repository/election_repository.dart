import 'package:elections_dapp/models/candidate.dart';
import 'package:elections_dapp/repository/election_web3_api_client.dart';
import 'package:elections_dapp/repository/endpoints.dart';
import 'package:uuid/uuid.dart';
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
  Future<String> callFunction(
      String functionName, String privateKey, List<dynamic> args) async {
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
    final id =  const Uuid().v4();
    await callFunction(
        'startElection', Endpoints.ownerPrivateKey(), [id, name, Endpoints.ownerPrivateKey()]);
    print('Election started successfully');
    print('Election Id: $id');
    return id;
  }

  Future<String> addCandidate(
      String candidateName, String candidateParty) async {
    final response = await callFunction(
      'addCandidate',
      Endpoints.ownerPrivateKey(),
      [candidateName, candidateParty],
    );
    print('Candidate added successfully');
    return response;
  }

  Future<String> authorizeVoter(String address) async {
    final response = await callFunction('authorizeVoter',
        Endpoints.ownerPrivateKey(), [EthereumAddress.fromHex(address)]);
    print('Voter successfully authorized');
    return response;
  }

  Future<List<Candidate>> getCandidates(String electionId) async {
    final contract = _electionWeb3ApiClient.getDeployedContract;
    final function = contract.function('getAlLCandidates');
    final candidatesRawList = await _electionWeb3ApiClient.ethWeb3client.call(
      contract: contract,
      function: function,
      params: [electionId],
    );

    List innerArray = candidatesRawList[0];
    List<Candidate> candidatesList = [];

    for (var i = 0; i < innerArray.length; i++) {
      final candidate = Candidate(
        name: innerArray[i][0],
        party: innerArray[i][1],
        votesNumber: innerArray[i][2].toInt(),
      );
      candidatesList.add(candidate);
    }
    return candidatesList;
  }

  Future<Candidate> getCandidateInfo(int index) async {
    final contract = _electionWeb3ApiClient.getDeployedContract;
    final function = contract.function('getCandidateInfo');
    final candidateInfo = await _electionWeb3ApiClient.ethWeb3client.call(
      contract: contract,
      function: function,
      params: [BigInt.from(index)],
    );
    print('Getting candidate info....');
    final candidate = Candidate(
      name: candidateInfo[0][0],
      party: candidateInfo[0][1],
      votesNumber: candidateInfo[0][2].toInt(),
    );
    return candidate;
  }

  Future<String> getTotalVotes() async {
    final voteCount =
        await callFunction('getTotalVotes', Endpoints.ownerPrivateKey(), []);
    return voteCount;
  }

  Future<String> vote(int candidateIndex) async {
    final response = await callFunction(
        'vote', Endpoints.voterPrivateKey(), [BigInt.from(candidateIndex)]);
    print('Vote counted successfully');
    return response;
  }
}
