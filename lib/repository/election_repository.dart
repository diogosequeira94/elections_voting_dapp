import 'package:elections_dapp/repository/election_web3_api_client.dart';
import 'package:web3dart/web3dart.dart';

/// Notes Repository
/// Responsible for CRUD operations and Error handling
class ElectionRepository {
  final ElectionWeb3Client _electionWeb3ApiClient = ElectionWeb3Client();

  static final _instance = ElectionRepository._internal();

  static ElectionRepository get instance => _instance;

  ElectionRepository._internal() {
    _electionWeb3ApiClient.init();
  }

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
    );
  }
}
