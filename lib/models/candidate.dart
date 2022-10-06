import 'package:equatable/equatable.dart';

class Candidate extends Equatable {
  final String id;
  final String name;
  final String party;
  final int votesNumber;
  final bool isSelected;

  const Candidate({
    required this.id,
    required this.name,
    required this.party,
    required this.votesNumber,
    this.isSelected = false,
  });

  Candidate copyWith({
    String? id,
    String? name,
    String? party,
    int? votesNumber,
    bool? isSelected,
  }) {
    return Candidate(
      id: id ?? this.id,
      name: name ?? this.name,
      party: party ?? this.party,
      votesNumber: votesNumber ?? this.votesNumber,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [name, party, votesNumber, isSelected];
}
