part of 'category_list_bloc.dart';

@immutable
abstract class CategoryListEvent {}

class LoadCategoryListEvent extends CategoryListEvent {
  final bool forceReload;

  LoadCategoryListEvent({this.forceReload = false});
}
