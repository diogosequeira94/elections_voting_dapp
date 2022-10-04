import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:elections_dapp/models/candidate.dart';
import 'package:elections_dapp/repository/election_repository.dart';
import 'package:equatable/equatable.dart';

part 'election_event.dart';
part 'election_state.dart';

class ElectionBloc extends Bloc<ElectionEvent, ElectionState> {
  final ElectionRepository electionRepository;
  int totalCandidates = 0;
  ElectionBloc({required this.electionRepository}) : super(ElectionInitial()) {
    on<StartElectionPressed>(_onStartElectionPressed);
    on<AddCandidatePressed>(_onAddCandidatePressed);
    on<AuthorizedVoterPressed>(_onAuthorizeVoterPressed);
    on<GetCandidateInfoPressed>(_onGetCandidateInfoPressed);
    on<FetchAllCandidates>(_onFetchAllCandidates);
  }

  Future<void> _onStartElectionPressed(StartElectionPressed event, Emitter<ElectionState> emit) async {
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

  Future<void> _onAddCandidatePressed(AddCandidatePressed event, Emitter<ElectionState> emit) async {
    emit(AddCandidateInProgress());
    try {
      await electionRepository.addCandidate(event.candidateName);
      totalCandidates++;
      emit(AddCandidateSuccess());
    } on Object catch (error) {
      print(error);
      emit(AddCandidateFailure());
    }
  }

  Future<void> _onAuthorizeVoterPressed(AuthorizedVoterPressed event, Emitter<ElectionState> emit) async {
    emit(AuthorizeVoterInProgress());
    try {
      await electionRepository.authorizeVoter(event.voterAddress);
      emit(AuthorizeVoterSuccess());
    } on Object catch (error) {
      print(error);
      emit(AuthorizeVoterFailure());
    }
  }

  Future<void> _onGetCandidateInfoPressed(GetCandidateInfoPressed event, Emitter<ElectionState> emit) async {
    emit(GetCandidateInfoInProgress());
    try {
      final candidate = await electionRepository.getCandidateInfo(event.index);
      emit(GetCandidateInfoSuccess(candidate));
    } on Object catch (error) {
      print(error);
      emit(GetCandidateInfoFailure());
    }
  }

  Future<void> _onFetchAllCandidates(FetchAllCandidates event, Emitter<ElectionState> emit) async {
    emit(FetchCandidatesInProgress());
    try {
      final candidatesList = await electionRepository.getCandidates();
      emit(FetchCandidatesSuccess(candidatesList));
    } on Object catch (error) {
      print(error);
      emit(FetchCandidatesFailure());
    }
  }
}
