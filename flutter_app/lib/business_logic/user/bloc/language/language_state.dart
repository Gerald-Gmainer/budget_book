part of 'language_bloc.dart';

@immutable
abstract class LanguageState {}

class LanguageInitState extends LanguageState {}

class LanguageLoadedState extends LanguageState {
  final Locale locale;

  LanguageLoadedState(this.locale);
}
