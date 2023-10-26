part of 'suggestion_bloc.dart';

@immutable
abstract class SuggestionEvent {}

class LoadSuggestionEvent extends SuggestionEvent {
  final bool forceReload;

  LoadSuggestionEvent({this.forceReload = false});
}

class ReloadSuggestionEvent extends SuggestionEvent {}
