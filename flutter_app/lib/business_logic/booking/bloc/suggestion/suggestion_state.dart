part of 'suggestion_bloc.dart';

@immutable
abstract class SuggestionState {}

class SuggestionInitState extends SuggestionState {}

class SuggestionLoadingState extends SuggestionState {}

class SuggestionLoadedState extends SuggestionState {
  final List<String> suggestions;

  SuggestionLoadedState(this.suggestions);
}

class SuggestionErrorState extends SuggestionState {
  final String message;

  SuggestionErrorState(this.message);
}
