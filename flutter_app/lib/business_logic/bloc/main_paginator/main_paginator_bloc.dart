import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/data/model/budget_book_model.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:meta/meta.dart';

part 'main_paginator_event.dart';
part 'main_paginator_state.dart';

class MainPaginatorBloc extends Bloc<MainPaginatorEvent, MainPaginatorState> {
  final BookingRepository bookingRepo;
  final BookingPeriodConverter _converter = BookingPeriodConverter();
  late BudgetBookModel _bookModel;

  MainPaginatorBloc(this.bookingRepo) : super(MainPaginatorInitState()) {
    on<InitMainPaginatorEvent>(_onInitMainPaginatorEvent);
    on<ChangePeriodMainPaginatorEvent>(_onChangePeriodMainPaginatorEvent);
    on<RefreshMainPaginatorEvent>(_onRefreshMainPaginatorEvent);
  }

  _onInitMainPaginatorEvent(InitMainPaginatorEvent event, Emitter<MainPaginatorState> emit) async {
    try {
      emit(MainPaginatorLoadingState());
      _bookModel = await _calculateBookModel(BudgetPeriod.month);
      emit(MainPaginatorLoadedState(_bookModel));
    } catch (e) {
      if (!ConnectivitySingleton.instance.isConnected()) {
        emit(MainPaginatorErrorState("TODO internet error message"));
      } else {
        BudgetLogger.instance.e(e);
        emit(MainPaginatorErrorState(e.toString()));
      }
    }
  }

  _onChangePeriodMainPaginatorEvent(ChangePeriodMainPaginatorEvent event, Emitter<MainPaginatorState> emit) async {
    try {
      emit(MainPaginatorLoadingState());
      _bookModel = await _calculateBookModel(event.period);
      emit(MainPaginatorLoadedState(_bookModel));
    } catch (e) {
      if (!ConnectivitySingleton.instance.isConnected()) {
        emit(MainPaginatorErrorState("TODO internet error message"));
      } else {
        BudgetLogger.instance.e(e);
        emit(MainPaginatorErrorState(e.toString()));
      }
    }
  }

  _onRefreshMainPaginatorEvent(RefreshMainPaginatorEvent event, Emitter<MainPaginatorState> emit) async {
    if (_bookModel == null) {
      add(InitMainPaginatorEvent());
      return;
    }
    try {
      emit(MainPaginatorLoadingState());
      _bookModel = await _calculateBookModel(_bookModel.currentPeriod);
      emit(MainPaginatorLoadedState(_bookModel));
    } catch (e) {
      if (!ConnectivitySingleton.instance.isConnected()) {
        emit(MainPaginatorErrorState("TODO internet error message"));
      } else {
        BudgetLogger.instance.e(e);
        emit(MainPaginatorErrorState(e.toString()));
      }
    }
  }

  _calculateBookModel(BudgetPeriod period) async {
    final currentPeriod = period;
    // final accounts = [] as List<AccountModel>;
    final bookings = await bookingRepo.getAllBookings();
    final periodModels = _converter.convertBookings(currentPeriod, bookings);
    return BudgetBookModel(
      currentPeriod: currentPeriod,
      periodModels: periodModels,
      accounts: [],
    );
  }
}
