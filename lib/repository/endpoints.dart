import 'package:meta/meta.dart';
import 'dart:io';

@immutable
class Endpoints {
  /// infura.io Ethereum Kovan DEV EP
  static String infuraApiUrl() => 'https://kovan.infura.io/v3/701c0bf7067e4979865d0122e2672075';

  /// infura's WebSocket url
  static String infuraWsUrl() => 'wss://kovan.infura.io/ws/v3/701c0bf7067e4979865d0122e2672075';

  /// Remote Procedure Call [RPC Server] from Ganache
  static String ganacheApiUrl() =>
      Platform.isAndroid ? 'http://10.0.2.2:7545' : 'http://127.0.0.1:7545';

  /// WebSocket Url
  static String ganacheWsUrl() =>
      Platform.isAndroid ? 'http://10.0.2.2:7545' : 'ws://127.0.0.1:7545/';

  /// Never use private keys in production, use walletconnect + metamask instead
  static String mockPrivateGanacheKey() =>
      'eac8360b2df979ebabc6e4e34d599381941bbdd41a9826485c02ddcbdaf69fa0';
}
