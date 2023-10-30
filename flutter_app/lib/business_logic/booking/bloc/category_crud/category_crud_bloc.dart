import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_crud_event.dart';
part 'category_crud_state.dart';

class CategoryCrudBloc extends Bloc<CategoryCrudEvent, CategoryCrudState> {
  final BookingRepository repo;
  final CategoryConverter _converter = CategoryConverter();

  CategoryCrudBloc(this.repo) : super(CategoryCrudInitState()) {
    on<InitCategoryCrudEvent>(_onInitCategoryCrudEvent);
    on<UploadCategoryCrudEvent>(_onUploadCategoryCrudEvent);
    on<DeleteCategoryCrudEvent>(_onDeleteCategoryCrudEvent);
  }

  _onInitCategoryCrudEvent(InitCategoryCrudEvent event, Emitter<CategoryCrudState> emit) async {
    emit(CategoryCrudInitState());
  }

  _onUploadCategoryCrudEvent(UploadCategoryCrudEvent event, Emitter<CategoryCrudState> emit) async {
    try {
      emit(CategoryCrudLoadingState());
      final model = _converter.toDataModel(event.model);
      if (event.model.id == null) {
        await repo.createCategory(model);
      } else {
        await repo.editCategory(model);
      }
      emit(CategoryCrudFinishedState());
    } catch (e) {
      if (!ConnectivitySingleton.instance.isConnected()) {
        emit(CategoryCrudErrorState("TODO internet error message"));
      } else {
        BudgetLogger.instance.e(e);
        final message = "Could not ${event.model.id == null ? "create" : "edit"} the category. Please try again";
        emit(CategoryCrudErrorState(message));
      }
    }
  }

  _onDeleteCategoryCrudEvent(DeleteCategoryCrudEvent event, Emitter<CategoryCrudState> emit) async {
    try {
      emit(CategoryCrudLoadingState());
      if (event.model.id == null) {
        throw "Cannot delete booking because ID is NULL";
      }
      await repo.deleteCategory(event.model.id!);
      emit(CategoryCrudDeletedState());
    } catch (e) {
      if (!ConnectivitySingleton.instance.isConnected()) {
        emit(CategoryCrudErrorState("TODO internet error message"));
      } else if (e.toString().contains("violates foreign key constraint")) {
        BudgetLogger.instance.e(e);
        emit(CategoryCrudErrorState("Category is still used and cannot be deleted"));
      } else {
        BudgetLogger.instance.e(e);
        emit(CategoryCrudErrorState("An error happened. Please try again"));
      }
    }
  }
}
