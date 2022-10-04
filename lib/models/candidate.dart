import 'package:equatable/equatable.dart';

class Candidate extends Equatable {
  final String name;
  final int votesNumber;

  const Candidate({required this.name, required this.votesNumber});

  @override
  List<Object?> get props => [name, votesNumber];
}
