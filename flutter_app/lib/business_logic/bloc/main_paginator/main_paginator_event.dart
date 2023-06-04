part of 'main_paginator_bloc.dart';

@immutable
abstract class MainPaginatorEvent {}

class InitMainPaginatorEvent extends MainPaginatorEvent {}

class ChangePeriodMainPaginatorEvent extends MainPaginatorEvent {
  final BudgetPeriod period;

  ChangePeriodMainPaginatorEvent(this.period);
}

class PaginateMainPaginatorEvent extends MainPaginatorEvent {
  final int direction;

  PaginateMainPaginatorEvent(this.direction);
}

class RefreshMainPaginatorEvent extends MainPaginatorEvent {
}
