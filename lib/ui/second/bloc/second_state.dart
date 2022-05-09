part of 'second_bloc.dart';

@immutable
abstract class SecondState {}

class InitialSte extends SecondState {}

class LoadingSte extends SecondState {}

class LoadedSte extends SecondState {}

class ErrorSte extends SecondState {}

class GoBackSte extends SecondState {}
