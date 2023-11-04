import 'package:flutter/material.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final UserRepository userRepo;
  LanguageBloc(this.userRepo) : super(LanguageInitState()) {
    on<LoadLanguageEvent>(_onLoadLanguageEvent);
    on<SetLanguageEvent>(_onSetLanguageEvent);
  }

  _onLoadLanguageEvent(LoadLanguageEvent event, Emitter<LanguageState> emit) async {
    final locale = Localizations.localeOf(event.context);
    emit(LanguageLoadedState(locale));
  }

  _onSetLanguageEvent(SetLanguageEvent event, Emitter<LanguageState> emit) async {
    emit(LanguageLoadedState(event.locale));
  }
}
