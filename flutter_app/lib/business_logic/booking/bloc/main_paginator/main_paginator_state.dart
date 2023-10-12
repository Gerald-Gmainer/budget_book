part of 'main_paginator_bloc.dart';

@immutable
abstract class MainPaginatorState {}

class MainPaginatorInitState extends MainPaginatorState {}

class MainPaginatorLoadingState extends MainPaginatorState {}

class MainPaginatorLoadedState extends MainPaginatorState {
  final BudgetBookModel bookModel;

  MainPaginatorLoadedState(this.bookModel);
}

class MainPaginatorErrorState extends MainPaginatorState {
  final String message;

  MainPaginatorErrorState(this.message);
}
