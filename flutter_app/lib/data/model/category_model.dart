import 'package:flutter_app/data/data.dart';

class CategoryModel extends DataModel {
  final String name;
  final CategoryType categoryType;

  CategoryModel({
    int? id,
    required this.name,
    required this.categoryType,
  }) : super(id);

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id'],
        name: json['name'],
        categoryType: json['type'] == "income" ? CategoryType.income : CategoryType.outcome,
      );

  @override
  String toString() {
    return [
      "id: $id",
      "name: $name",
      "categoryType: $categoryType",
    ].join(" / ");
  }
}
