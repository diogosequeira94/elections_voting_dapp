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

class AddCandidateInProgress extends ElectionState {
  @override
  List<Object> get props => [];
}

class AddCandidateSuccess extends ElectionState {
  @override
  List<Object> get props => [];
}

class AddCandidateFailure extends ElectionState {
  @override
  List<Object> get props => [];
}

class AuthorizeVoterInProgress extends ElectionState {
  @override
  List<Object> get props => [];
}

class AuthorizeVoterSuccess extends ElectionState {
  @override
  List<Object> get props => [];
}

class AuthorizeVoterFailure extends ElectionState {
  @override
  List<Object> get props => [];
}

class AuthorizeVoterAlreadyAuthorized extends AuthorizeVoterFailure {
  @override
  List<Object> get props => [];
}

class GetCandidateInfoInProgress extends ElectionState {
  @override
  List<Object> get props => [];
}

class GetCandidateInfoSuccess extends ElectionState {
  final Candidate candidate;
  const GetCandidateInfoSuccess(this.candidate);
  @override
  List<Object> get props => [candidate];
}

class GetCandidateInfoFailure extends ElectionState {
  @override
  List<Object> get props => [];
}

class FetchCandidatesInProgress extends ElectionState {
  @override
  List<Object> get props => [];
}

class FetchCandidatesSuccess extends ElectionState {
  final List<Candidate> candidates;
  const FetchCandidatesSuccess(this.candidates);
  @override
  List<Object> get props => [candidates];
}

class FetchCandidatesFailure extends ElectionState {
  @override
  List<Object> get props => [];
}

class SelectedAddressUpdated extends ElectionState {
  final String updatedAddress;
  const SelectedAddressUpdated({required this.updatedAddress});
  @override
  List<Object> get props => [updatedAddress];
}

class CandidateSelectedUpdated extends FetchCandidatesSuccess {
  final List<Candidate> candidates;

  const CandidateSelectedUpdated({required this.candidates}) : super(candidates);
  @override
  List<Object> get props => [candidates];
}

