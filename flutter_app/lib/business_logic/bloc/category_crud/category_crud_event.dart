part of 'category_crud_bloc.dart';

@immutable
abstract class CategoryCrudEvent {}

class InitCategoryCrudEvent extends CategoryCrudEvent {}

class UploadCategoryCrudEvent extends CategoryCrudEvent {
  final CategoryModel model;

  UploadCategoryCrudEvent(this.model);
}
