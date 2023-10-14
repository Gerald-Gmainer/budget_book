part of 'graph_view_bloc.dart';

@immutable
abstract class GraphViewEvent {}

class InitGraphViewEvent extends GraphViewEvent {}

class ChangePeriodGraphViewEvent extends GraphViewEvent {
  final BudgetPeriod period;

  ChangePeriodGraphViewEvent(this.period);
}

class RefreshGraphViewEvent extends GraphViewEvent {
}
