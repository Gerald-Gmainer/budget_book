import 'package:flutter_app/data/data.dart';

class CategoryDataModel extends DataModel {
  String? name;
  final CategoryType categoryType;

  CategoryDataModel.empty(this.categoryType) : super(null);

  CategoryDataModel({
    int? id,
    this.name,
    required this.categoryType,
  }) : super(id);

  factory CategoryDataModel.fromJson(Map<String, dynamic> json) => CategoryDataModel(
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
