part of 'category_crud_bloc.dart';

@immutable
abstract class CategoryCrudState {}

class CategoryCrudInitState extends CategoryCrudState {}

class CategoryCrudLoadingState extends CategoryCrudState {}

class CategoryCrudFinishedState extends CategoryCrudState {}

class CategoryCrudDeletedState extends CategoryCrudState {

}

class CategoryCrudErrorState extends CategoryCrudState {
  final String message;

  CategoryCrudErrorState(this.message);
}
