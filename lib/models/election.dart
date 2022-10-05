import 'package:equatable/equatable.dart';

class Election extends Equatable {
  final String id;
  final String name;
  final String creatorAddress;
  const Election({
    required this.id,
    required this.name,
    required this.creatorAddress,
  });

  @override
  List<Object?> get props => [id, name, creatorAddress];
}
