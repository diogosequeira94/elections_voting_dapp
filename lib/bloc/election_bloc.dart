import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:elections_dapp/models/candidate.dart';
import 'package:elections_dapp/repository/election_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

part 'election_event.dart';
part 'election_state.dart';

class ElectionBloc extends Bloc<ElectionEvent, ElectionState> {
  final ElectionRepository electionRepository;
  ElectionBloc({required this.electionRepository}) : super(ElectionInitial()) {
    on<StartElectionPressed>(_onStartElectionPressed);
    on<AddCandidatePressed>(_onAddCandidatePressed);
    on<AuthorizedVoterPressed>(_onAuthorizeVoterPressed);
    on<GetCandidateInfoPressed>(_onGetCandidateInfoPressed);
    on<FetchAllCandidates>(_onFetchAllCandidates);
    on<VoterAddressSelected>(_onVoterAddressSelected);
    on<CandidateCheckboxSelected>(_onCandidateSelectionUpdated);
  }

  late List<Candidate> candidatesList;
  String? _currentSelectedAddress;
  Candidate? _selectedCandidate = null;
  int totalCandidates = 0;
  final _votersAddresses = [
    '0x7945A4B80a73a3dEE4d06aAdCED71799670cA369',
    '0xb92f5E793B2EA586d68668817C387A70Cb68778D',
  ];


  String? get selectedAddress => _currentSelectedAddress;
  Candidate? get selectedCandidate => _selectedCandidate;
  List get getVotersAddresses => _votersAddresses;

  Future<void> _onStartElectionPressed(StartElectionPressed event, Emitter<ElectionState> emit) async {
    emit(ElectionStartInProgress());
    await Future.delayed(const Duration(seconds: 2));
    try {
      await electionRepository.startElection(event.electionName);
      emit(ElectionStartSuccess(electionName: event.electionName));
    } on Object catch (_) {
      emit(ElectionStartFailure());
    }
  }

  Future<void> _onAddCandidatePressed(AddCandidatePressed event, Emitter<ElectionState> emit) async {
    emit(AddCandidateInProgress());
    try {
      await electionRepository.addCandidate(event.candidateName, event.party);
      totalCandidates++;
      emit(AddCandidateSuccess());
    } on Object catch (_) {
      emit(AddCandidateFailure());
    }
  }

  Future<void> _onAuthorizeVoterPressed(AuthorizedVoterPressed event, Emitter<ElectionState> emit) async {
    emit(AuthorizeVoterInProgress());
    try {
      await electionRepository.authorizeVoter(event.voterAddress);
      emit(AuthorizeVoterSuccess());
    } on Object catch (_) {
      emit(AuthorizeVoterFailure());
    }
  }

  Future<void> _onGetCandidateInfoPressed(GetCandidateInfoPressed event, Emitter<ElectionState> emit) async {
    emit(GetCandidateInfoInProgress());
    try {
      final candidate = await electionRepository.getCandidateInfo(event.index);
      emit(GetCandidateInfoSuccess(candidate));
    } on Object catch (_) {
      emit(GetCandidateInfoFailure());
    }
  }

  Future<void> _onFetchAllCandidates(FetchAllCandidates event, Emitter<ElectionState> emit) async {
    emit(FetchCandidatesInProgress());
    try {
      candidatesList = await electionRepository.getCandidates();
      emit(FetchCandidatesSuccess(candidatesList));
    } on Object catch (_) {
      emit(FetchCandidatesFailure());
    }
  }

  Future<void> _onVoterAddressSelected(VoterAddressSelected event, Emitter<ElectionState> emit) async {
    _currentSelectedAddress = event.selectedAddress;
    emit(SelectedAddressUpdated(updatedAddress: _currentSelectedAddress!));
  }


  Future<void> _onCandidateSelectionUpdated(CandidateCheckboxSelected event, Emitter<ElectionState> emit) async {
    final selectedCandidate = candidatesList[event.index];
    final updatedList = candidatesList.map((candidate) =>
      candidate.id == selectedCandidate.id ?
        candidate.copyWith(
          isSelected: !candidate.isSelected,
        ) : candidate
    ).toList();
    _selectedCandidate = updatedList.singleWhereOrNull((candidate) => candidate.isSelected);
    candidatesList = updatedList;
    emit(CandidateSelectedUpdated(candidates: candidatesList));
  }
}
