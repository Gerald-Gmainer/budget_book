part of 'suggestion_bloc.dart';

@immutable
abstract class SuggestionEvent {}

class LoadSuggestionEvent extends SuggestionEvent {}

class ReloadSuggestionEvent extends SuggestionEvent {}
