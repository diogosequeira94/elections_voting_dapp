import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:elections_dapp/repository/election_repository.dart';
import 'package:equatable/equatable.dart';

part 'election_event.dart';
part 'election_state.dart';

class ElectionBloc extends Bloc<ElectionEvent, ElectionState> {
  final ElectionRepository electionRepository;
  ElectionBloc({required this.electionRepository}) : super(ElectionInitial()) {
    on<StartElectionPressed>(_onStartElectionPressed);
  }

  Future<void> _onStartElectionPressed(StartElectionPressed event, Emitter<ElectionState> emit) async {
    emit(ElectionStartInProgress());
    await Future.delayed(const Duration(seconds: 3));
    try {
      await electionRepository.startElection(event.electionName);
      emit(ElectionStartSuccess(electionName: event.electionName));
    } on Object catch (error) {
      print(error);
      emit(ElectionStartFailure());
    }
  }
}
