part of 'graph_view_bloc.dart';

@immutable
abstract class GraphViewState {}

class GraphViewInitState extends GraphViewState {}

class GraphViewLoadingState extends GraphViewState {}

class GraphViewLoadedState extends GraphViewState {
  final BudgetBookModel bookModel;

  GraphViewLoadedState(this.bookModel);
}

class GraphViewErrorState extends GraphViewState {
  final String message;

  GraphViewErrorState(this.message);
}
