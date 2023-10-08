import 'package:flutter_app/data/data.dart';

class CategoryModel {
  final CategoryDataModel dataModel;
  final CategoryType categoryType;

  CategoryModel.empty(this.categoryType) : dataModel = CategoryDataModel.empty(categoryType);

  CategoryModel(this.dataModel, this.categoryType);
}
