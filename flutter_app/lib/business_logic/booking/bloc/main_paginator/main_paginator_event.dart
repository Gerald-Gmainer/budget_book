part of 'main_paginator_bloc.dart';

@immutable
abstract class MainPaginatorEvent {}

class InitMainPaginatorEvent extends MainPaginatorEvent {}

class ChangePeriodMainPaginatorEvent extends MainPaginatorEvent {
  final BudgetPeriod period;

  ChangePeriodMainPaginatorEvent(this.period);
}

class RefreshMainPaginatorEvent extends MainPaginatorEvent {
}
