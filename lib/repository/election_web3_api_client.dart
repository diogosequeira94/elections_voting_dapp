import 'dart:convert';

import 'package:elections_dapp/repository/endpoints.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class ElectionWeb3Client {
  late Web3Client ethWeb3client;
  late DeployedContract _deployedContract;
  late ContractAbi _contractAbiCode;
  late EthereumAddress _contractAddress;
  late EthPrivateKey _credentials;

  static const electionContractPath = 'assets/contracts/Election.json';

  EthPrivateKey get getCredentials => _credentials;
  DeployedContract get getDeployedContract => _deployedContract;

  Future<void> init() async {
    ethWeb3client = Web3Client(
      Endpoints.ganacheApiUrl(),
      Client(),
      socketConnector: () {
        return IOWebSocketChannel.connect(Endpoints.ganacheWsUrl())
            .cast<String>();
      },
    );
    _contractAbiCode = await _getABI();
    _contractAddress = await _getAddress(_contractAbiCode);
    _credentials = await _getCredentials();
    _deployedContract = await loadContract();
  }

  Future<ContractAbi> _getABI() async {
    final abiFile = await rootBundle.loadString(electionContractPath);
    final jsonABI = jsonDecode(abiFile);
    return ContractAbi.fromJson(jsonEncode(jsonABI['abi']), 'Election');
  }

  Future<EthereumAddress> _getAddress(ContractAbi contractAbi) async {
    final abiFile = await rootBundle.loadString(electionContractPath);
    final jsonABI = jsonDecode(abiFile);
    return EthereumAddress.fromHex(jsonABI["networks"]["5777"]["address"]);
  }

  Future<EthPrivateKey> _getCredentials() async {
    return EthPrivateKey.fromHex(Endpoints.ownerPrivateKey());
  }

  Future<DeployedContract> loadContract() async {
    final contract = DeployedContract(_contractAbiCode, _contractAddress);
    return contract;
  }
}
