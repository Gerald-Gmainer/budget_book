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
  BudgetPeriod _currentBudgetPeriod = BudgetPeriod.month;

  MainPaginatorBloc(this.bookingRepo) : super(MainPaginatorInitState()) {
    on<InitMainPaginatorEvent>(_onInitMainPaginatorEvent);
    on<ChangePeriodMainPaginatorEvent>(_onChangePeriodMainPaginatorEvent);
    on<RefreshMainPaginatorEvent>(_onRefreshMainPaginatorEvent);
  }

  _onInitMainPaginatorEvent(InitMainPaginatorEvent event, Emitter<MainPaginatorState> emit) async {
    try {
      emit(MainPaginatorLoadingState());
      final bookModel = await _calculateBookModel(_currentBudgetPeriod);
      emit(MainPaginatorLoadedState(bookModel));
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
      _currentBudgetPeriod = event.period;
      final bookModel = await _calculateBookModel(event.period);
      emit(MainPaginatorLoadedState(bookModel));
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
    try {
      emit(MainPaginatorLoadingState());
      final bookModel = await _calculateBookModel(_currentBudgetPeriod);
      emit(MainPaginatorLoadedState(bookModel));
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
    final categories = await bookingRepo.getAllCategories();
    final periodModels = _converter.convertBookings(currentPeriod, bookings, categories);
    return BudgetBookModel(
      currentPeriod: currentPeriod,
      periodModels: periodModels,
      accounts: [],
      categories: categories,
    );
  }
}
