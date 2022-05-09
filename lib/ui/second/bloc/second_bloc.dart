import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:testing_base_stateful/ui/second/repository/second_repository.dart';

part 'second_event.dart';

part 'second_state.dart';

class SecondBloc extends Bloc<SecondEvent, SecondState> {
  final BaseSecondRepository repository;

  SecondBloc(this.repository) : super(InitialSte()) {
    on<SecondEvent>((event, emit) async {
      if (event is StartApiEvt) {
        emit(LoadingSte());
        emit(await repository.callApi());
      } else if (event is GoBackEvt) {
        emit(GoBackSte());
      }
    });
  }
}
