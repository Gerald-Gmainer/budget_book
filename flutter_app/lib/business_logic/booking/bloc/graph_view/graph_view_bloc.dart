import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/enum/enum.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'graph_view_event.dart';
part 'graph_view_state.dart';

class GraphViewBloc extends Bloc<GraphViewEvent, GraphViewState> {
  final BookingRepository bookingRepo;
  final BookingPeriodConverter _bookingPeriodConverter = BookingPeriodConverter();
  final CategoryConverter _categoryConverter = CategoryConverter();
  final AccountConverter _accountConverter = AccountConverter();
  BudgetPeriod _currentBudgetPeriod = BudgetPeriod.month;

  GraphViewBloc(this.bookingRepo) : super(GraphViewInitState()) {
    on<InitGraphViewEvent>(_onInitGraphViewEvent);
    on<ChangePeriodGraphViewEvent>(_onChangePeriodGraphViewEvent);
    on<RefreshGraphViewEvent>(_onRefreshGraphViewEvent);
  }

  _onInitGraphViewEvent(InitGraphViewEvent event, Emitter<GraphViewState> emit) async {
    try {
      emit(GraphViewLoadingState());
      final bookModel = await _calculateBookModel(_currentBudgetPeriod);
      emit(GraphViewLoadedState(bookModel));
    } catch (e) {
      if (!ConnectivitySingleton.instance.isConnected()) {
        emit(GraphViewErrorState("TODO internet error message"));
      } else {
        BudgetLogger.instance.e(e);
        emit(GraphViewErrorState(e.toString()));
      }
    }
  }

  _onChangePeriodGraphViewEvent(ChangePeriodGraphViewEvent event, Emitter<GraphViewState> emit) async {
    try {
      emit(GraphViewLoadingState());
      _currentBudgetPeriod = event.period;
      final bookModel = await _calculateBookModel(event.period);
      emit(GraphViewLoadedState(bookModel));
    } catch (e) {
      if (!ConnectivitySingleton.instance.isConnected()) {
        emit(GraphViewErrorState("TODO internet error message"));
      } else {
        BudgetLogger.instance.e(e);
        emit(GraphViewErrorState(e.toString()));
      }
    }
  }

  _onRefreshGraphViewEvent(RefreshGraphViewEvent event, Emitter<GraphViewState> emit) async {
    try {
      emit(GraphViewLoadingState());
      final bookModel = await _calculateBookModel(_currentBudgetPeriod);
      emit(GraphViewLoadedState(bookModel));
    } catch (e) {
      if (!ConnectivitySingleton.instance.isConnected()) {
        emit(GraphViewErrorState("TODO internet error message"));
      } else {
        BudgetLogger.instance.e(e);
        emit(GraphViewErrorState(e.toString()));
      }
    }
  }

  _calculateBookModel(BudgetPeriod period) async {
    final currentPeriod = period;
    await bookingRepo.checkToken();

    final futures = <Future>[bookingRepo.getAllBookings(), bookingRepo.getAllCategories(), bookingRepo.getIconCache(), bookingRepo.getAccounts()];
    final results = await Future.wait(futures);
    final bookingDataModels = results[0];
    final categoryDataModels = results[1];
    final iconCache = results[2];
    final accountDataModels = results[3];

    final categories = _categoryConverter.fromDataModels(categoryDataModels, iconCache);
    final periodModels = _bookingPeriodConverter.convertBookings(currentPeriod, bookingDataModels, categories);
    final accounts = _accountConverter.fromDataModels(accountDataModels, iconCache);
    return BudgetBookModel(
      currentPeriod: currentPeriod,
      periodModels: periodModels,
      accounts: accounts,
      categories: categories,
    );
  }
}
