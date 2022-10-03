part of 'election_bloc.dart';

abstract class ElectionEvent extends Equatable {
  const ElectionEvent();
}

class StartElectionPressed extends ElectionEvent {
  final String electionName;
  const StartElectionPressed({required this.electionName});

  @override
  List<Object?> get props => [electionName];
}
