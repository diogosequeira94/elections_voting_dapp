import 'package:equatable/equatable.dart';

class Candidate extends Equatable {
  final String name;
  final String party;
  final int votesNumber;

  const Candidate({required this.name, required this.party, required this.votesNumber});

  @override
  List<Object?> get props => [name, party, votesNumber];
}
