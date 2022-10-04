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
    on<AddCandidatePressed>(_onAddCandidatePressed);
    on<AuthorizedVoterPressed>(_onAuthorizeVoterPressed);
  }

  Future<void> _onStartElectionPressed(
      StartElectionPressed event, Emitter<ElectionState> emit) async {
    emit(ElectionStartInProgress());
    await Future.delayed(const Duration(seconds: 2));
    try {
      await electionRepository.startElection(event.electionName);
      emit(ElectionStartSuccess(electionName: event.electionName));
    } on Object catch (error) {
      print(error);
      emit(ElectionStartFailure());
    }
  }

  Future<void> _onAddCandidatePressed(
      AddCandidatePressed event, Emitter<ElectionState> emit) async {
    emit(AddCandidateInProgress());
    try {
      await electionRepository.addCandidate(event.candidateName);
      emit(AddCandidateSuccess());
    } on Object catch (error) {
      print(error);
      emit(AddCandidateFailure());
    }
  }

  Future<void> _onAuthorizeVoterPressed(
      AuthorizedVoterPressed event, Emitter<ElectionState> emit) async {
    emit(AuthorizeVoterInProgress());
    try {
      await electionRepository.authorizeVoter(event.voterAddress);
      emit(AuthorizeVoterSuccess());
    } on Object catch (error) {
      print(error);
      emit(AuthorizeVoterFailure());
    }
  }
}
