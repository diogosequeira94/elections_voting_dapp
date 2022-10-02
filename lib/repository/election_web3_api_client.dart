import 'dart:convert';

import 'package:elections_dapp/repository/endpoints.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class ElectionWeb3Client {
  late Web3Client ethWeb3client;
 // late ElectionDeployedContract _electionDeployedContract;
  late ContractAbi _contractAbiCode;
  late EthereumAddress _contractAddress;
  late EthPrivateKey _credentials;

  static const electionContractPath = 'assets/contracts/election.json';

  EthPrivateKey get getCredentials => _credentials;
 // ElectionDeployedContract get getNotesDeployedContract => _electionDeployedContract;

  Future<void> init() async {
    ethWeb3client = Web3Client(
      Endpoints.ganacheApiUrl(),
      Client(),
      socketConnector: () {
        return IOWebSocketChannel.connect(Endpoints.ganacheWsUrl()).cast<String>();
      },
    );
   // _electionDeployedContract = ElectionDeployedContract();
    await _getABI();
    await _getAddress(_contractAbiCode);
    await _getCredentials();
   // await _electionDeployedContract.initContract(_contractAbiCode, _contractAddress);
  }

  Future<void> _getABI() async {
    final abiFile = await rootBundle.loadString(electionContractPath);
    final jsonABI = jsonDecode(abiFile);
    _contractAbiCode =
        ContractAbi.fromJson(jsonEncode(jsonABI['abi']), 'Election');
  }

  Future<void> _getAddress(ContractAbi contractAbi) async {
    final abiFile = await rootBundle.loadString(electionContractPath);
    final jsonABI = jsonDecode(abiFile);
    _contractAddress =
        EthereumAddress.fromHex(jsonABI["networks"]["5777"]["address"]);
  }

  Future<void> _getCredentials() async {
    _credentials = EthPrivateKey.fromHex(Endpoints.ownerPrivateKey());
    // /// Test logs
    // EtherAmount balance = await web3client.getBalance(_credentials.address);
    // print(balance.getValueInUnit(EtherUnit.ether));
  }
}