import 'package:meta/meta.dart';
import 'dart:io';

@immutable
class Endpoints {
  /// infura.io Ethereum Kovan DEV EP
  static String infuraUrl() => 'https://kovan.infura.io/v3/701c0bf7067e4979865d0122e2672075';

  /// infura's WebSocket url
  static String infuraWsUrl() => 'wss://kovan.infura.io/ws/v3/701c0bf7067e4979865d0122e2672075';

  /// Never use private keys in production, use walletconnect + metamask instead
  static String mockPrivateGanacheKey() =>
      'eac8360b2df979ebabc6e4e34d599381941bbdd41a9826485c02ddcbdaf69fa0';
}
