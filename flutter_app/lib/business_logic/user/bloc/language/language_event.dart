part of 'language_bloc.dart';

@immutable
abstract class LanguageEvent {}

class LoadLanguageEvent extends LanguageEvent {
  final BuildContext context;

  LoadLanguageEvent(this.context);
}

class SetLanguageEvent extends LanguageEvent {
  final Locale locale;

  SetLanguageEvent(this.locale);
}
