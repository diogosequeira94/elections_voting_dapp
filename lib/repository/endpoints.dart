import 'package:meta/meta.dart';
import 'dart:io';

@immutable
class Endpoints {
  /// infura.io Ethereum Kovan DEV EP
  static String infuraApiUrl() => 'https://kovan.infura.io/v3/701c0bf7067e4979865d0122e2672075';

  /// infura's WebSocket url
  static String infuraWsUrl() => 'wss://kovan.infura.io/ws/v3/701c0bf7067e4979865d0122e2672075';

  /// Remote Procedure Call [RPC Server] from Ganache
  static String ganacheApiUrl() => Platform.isAndroid ? 'http://10.0.2.2:7545' : 'http://127.0.0.1:7545';

  /// WebSocket Url
  static String ganacheWsUrl() => Platform.isAndroid ? 'http://10.0.2.2:7545' : 'ws://127.0.0.1:7545/';

  /// Mock private keys from Ganache
  static String ownerPrivateKey() => '389bd8a69fd2b4506fa1d9432fcf70d2ebd9e4b8b2600c42485711eb3765a302';

  static String voterPrivateKey() => 'c3f61c06b2fb3368d37696fa59099fee2dd995d41fc53d7ad0df8a52769a80';
}
