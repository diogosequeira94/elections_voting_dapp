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

class AddCandidatePressed extends ElectionEvent {
  final String candidateName;
  final String party;
  const AddCandidatePressed({
    required this.candidateName,
    required this.party,
  });

  @override
  List<Object?> get props => [candidateName, party];
}

class AuthorizedVoterPressed extends ElectionEvent {
  final String voterAddress;
  const AuthorizedVoterPressed({required this.voterAddress});

  @override
  List<Object?> get props => [voterAddress];
}

class GetCandidateInfoPressed extends ElectionEvent {
  final int index;
  const GetCandidateInfoPressed({required this.index});

  @override
  List<Object?> get props => [index];
}

class FetchAllCandidates extends ElectionEvent {
  @override
  List<Object?> get props => [];
}

class VoterAddressSelected extends ElectionEvent {
  final String selectedAddress;
  const VoterAddressSelected(this.selectedAddress);
  @override
  List<Object?> get props => [selectedAddress];
}

class CandidateCheckboxSelected extends ElectionEvent {
  final bool isSelected;
  const CandidateCheckboxSelected(this.isSelected);
  @override
  List<Object?> get props => [isSelected];
}
