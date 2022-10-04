import 'package:equatable/equatable.dart';

class Voter extends Equatable {
  final String name;
  final int candidateChosen;
  final bool isAuthorised;
  final bool hasVoted;

  const Voter({
    required this.name,
    required this.candidateChosen,
    required this.isAuthorised,
    required this.hasVoted,
  });

  @override
  List<Object?> get props => [name, candidateChosen, isAuthorised, hasVoted];
}
