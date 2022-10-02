import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'election_event.dart';
part 'election_state.dart';

class ElectionBloc extends Bloc<ElectionEvent, ElectionState> {
  ElectionBloc() : super(ElectionInitial()) {
    on<ElectionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
