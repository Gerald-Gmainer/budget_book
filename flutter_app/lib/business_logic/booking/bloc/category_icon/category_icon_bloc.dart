import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_icon_event.dart';
part 'category_icon_state.dart';

class CategoryIconBloc extends Bloc<CategoryIconEvent, CategoryIconState> {
  final BookingRepository repo;
  final CategoryConverter _converter = CategoryConverter();

  CategoryIconBloc(this.repo) : super(CategoryIconInitState()) {
    on<LoadCategoryIconEvent>(_onLoadCategoryIconEvent);
  }

  _onLoadCategoryIconEvent(LoadCategoryIconEvent event, Emitter<CategoryIconState> emit) async {
    try {
      emit(CategoryIconLoadingState());
      final IconCacheModel cacheModel = await repo.getIconCache();
      final icons = _converter.fromIconDataModels(cacheModel.categoryIcons);
      final colors = _converter.fromColorDataModels(cacheModel.categoryColors);
      emit(CategoryIconLoadedState(icons, colors));
    } catch (e) {
      if (!ConnectivitySingleton.instance.isConnected()) {
        emit(CategoryIconErrorState("TODO internet error message"));
      } else {
        BudgetLogger.instance.e(e);
        emit(CategoryIconErrorState(e.toString()));
      }
    }
  }
}
