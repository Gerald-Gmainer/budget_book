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
  final BookingPeriodConverter _converter = BookingPeriodConverter();
  final CategoryConverter _categoryConverter = CategoryConverter();
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
    // final accounts = [] as List<AccountModel>;
    final bookingDataModels = await bookingRepo.getAllBookings();
    final categoryDataModels = await bookingRepo.getAllCategories();
    final iconCache = await bookingRepo.getIconCache();

    final categories = _categoryConverter.fromDataModels(categoryDataModels, iconCache.categoryIcons, iconCache.categoryColors);
    final periodModels = _converter.convertBookings(currentPeriod, bookingDataModels, categories);
    return BudgetBookModel(
      currentPeriod: currentPeriod,
      periodModels: periodModels,
      accounts: [],
      categories: categories,
    );
  }
}