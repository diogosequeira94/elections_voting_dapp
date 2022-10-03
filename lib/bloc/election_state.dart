part of 'election_bloc.dart';

abstract class ElectionState extends Equatable {
  const ElectionState();
}

class ElectionInitial extends ElectionState {
  @override
  List<Object> get props => [];
}

class ElectionStartInProgress extends ElectionState {
  @override
  List<Object> get props => [];
}

class ElectionStartSuccess extends ElectionState {
  final String electionName;
  const ElectionStartSuccess({required this.electionName});
  @override
  List<Object> get props => [electionName];
}

class ElectionStartFailure extends ElectionState {
  @override
  List<Object> get props => [];
}
