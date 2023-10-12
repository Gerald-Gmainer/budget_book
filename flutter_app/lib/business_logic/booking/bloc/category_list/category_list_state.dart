part of 'category_list_bloc.dart';

@immutable
abstract class CategoryListState {}

class CategoryListInitState extends CategoryListState {}

class CategoryLoadingState extends CategoryListState {}

class CategoryLoadedState extends CategoryListState {
  final List<CategoryModel> categories;

  CategoryLoadedState(this.categories);
}

class CategoryErrorState extends CategoryListState {
  final String message;

  CategoryErrorState(this.message);
}
