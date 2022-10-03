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
  @override
  List<Object> get props => [];
}

class ElectionStartFailure extends ElectionState {
  @override
  List<Object> get props => [];
}
