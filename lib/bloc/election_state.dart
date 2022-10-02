part of 'election_bloc.dart';

abstract class ElectionState extends Equatable {
  const ElectionState();
}

class ElectionInitial extends ElectionState {
  @override
  List<Object> get props => [];
}
