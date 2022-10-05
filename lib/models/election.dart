import 'package:equatable/equatable.dart';

class Election extends Equatable {
  final String electionId;
  final String electionName;
  final String creatorAddress;
  const Election({
    required this.electionId,
    required this.electionName,
    required this.creatorAddress,
  });

  @override
  List<Object?> get props => [electionId, electionName, creatorAddress];
}
