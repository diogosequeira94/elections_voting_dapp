import 'package:equatable/equatable.dart';

class Candidate extends Equatable {
  final String name;
  final String party;
  final int votesNumber;
  final bool isSelected;

  const Candidate({
    required this.name,
    required this.party,
    required this.votesNumber,
    this.isSelected = false,
  });

  @override
  List<Object?> get props => [name, party, votesNumber, isSelected];
}
