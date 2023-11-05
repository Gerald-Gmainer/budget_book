import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_list_event.dart';
part 'category_list_state.dart';

class CategoryListBloc extends Bloc<CategoryListEvent, CategoryListState> {
  final BookingRepository repo;
  final CategoryConverter _categoryConverter = CategoryConverter();

  CategoryListBloc(this.repo) : super(CategoryListInitState()) {
    on<LoadCategoryListEvent>(_onLoadCategoryListEvent);
  }

  _onLoadCategoryListEvent(LoadCategoryListEvent event, Emitter<CategoryListState> emit) async {
    try {
      emit(CategoryLoadingState());
      final categoryDataModels = await repo.getAllCategories(forceReload: event.forceReload);
      final iconCache = await repo.getIconCache();
      final categories = _categoryConverter.fromDataModels(categoryDataModels, iconCache);
      emit(CategoryLoadedState(categories));
    } catch (e) {
      if (!ConnectivitySingleton.instance.isConnected()) {
        emit(CategoryErrorState("error.internet"));
      } else {
        BudgetLogger.instance.e(e);
        emit(CategoryErrorState("error.default"));
      }
    }
  }
}
