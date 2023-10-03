import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_list_event.dart';
part 'category_list_state.dart';

class CategoryListBloc extends Bloc<CategoryListEvent, CategoryListState> {
  final BookingRepository repo;

  CategoryListBloc(this.repo) : super(CategoryListInitState()) {
    on<LoadCategoryListEvent>(_onLoadCategoryListEvent);
  }

  _onLoadCategoryListEvent(LoadCategoryListEvent event, Emitter<CategoryListState> emit) async {
    try {
      emit(CategoryLoadingState());
      final dataModels = await repo.getAllCategories();
      // TODO use converter
      emit(CategoryLoadedState(dataModels.map((e) => CategoryModel(e, e.categoryType)).toList()));
    } catch (e) {
      if (!ConnectivitySingleton.instance.isConnected()) {
        emit(CategoryErrorState("TODO internet error message"));
      } else {
        BudgetLogger.instance.e(e);
        emit(CategoryErrorState(e.toString()));
      }
    }
  }
}
