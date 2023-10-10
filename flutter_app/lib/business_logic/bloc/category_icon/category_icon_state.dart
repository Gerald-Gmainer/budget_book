part of 'category_icon_bloc.dart';

@immutable
abstract class CategoryIconState {}

class CategoryIconInitState extends CategoryIconState {}

class CategoryIconLoadingState extends CategoryIconState{}

class CategoryIconLoadedState extends CategoryIconState {
  final List<CategoryIconDataModel> categoryIcons;
  final List<CategoryColorDataModel> categoryColors;

  CategoryIconLoadedState(this.categoryIcons, this.categoryColors);
}

class CategoryIconErrorState extends CategoryIconState {
  final String message;

  CategoryIconErrorState(this.message);
}
