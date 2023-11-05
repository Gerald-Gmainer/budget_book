import 'package:flutter/material.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'suggestion_event.dart';
part 'suggestion_state.dart';

class SuggestionBloc extends Bloc<SuggestionEvent, SuggestionState> {
  final BookingRepository repo;
  final UserRepository userRepo;

  SuggestionBloc(this.repo, this.userRepo) : super(SuggestionInitState()) {
    on<LoadSuggestionEvent>(_onLoadSuggestionEvent);
  }

  _onLoadSuggestionEvent(LoadSuggestionEvent event, Emitter<SuggestionState> emit) async {
    try {
      emit(SuggestionLoadingState());
      final suggestions = await repo.getSuggestions(forceReload: event.forceReload);
      emit(SuggestionLoadedState(suggestions));
    } catch (e) {
      if (!ConnectivitySingleton.instance.isConnected()) {
        emit(SuggestionErrorState("error.internet"));
      } else {
        BudgetLogger.instance.e(e);
        emit(SuggestionErrorState("error.default"));
      }
    }
  }
}
