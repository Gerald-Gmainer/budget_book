import 'package:flutter_app/data/data.dart';

class CategoryDataModel extends DataModel {
  String? name;
  int? iconId;
  int? colorId;
  CategoryType categoryType;

  CategoryDataModel({
    int? id,
    this.name,
    this.iconId,
    this.colorId,
    required this.categoryType,
  }) : super(id);

  factory CategoryDataModel.fromJson(Map<String, dynamic> json) => CategoryDataModel(
        id: json['id'],
        name: json['name'],
        iconId: json['icon_id'],
        colorId: json['color_id'],
        categoryType: json['type'] == "income" ? CategoryType.income : CategoryType.outcome,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon_id': iconId,
      'color_id': colorId,
      'type': categoryType == CategoryType.income ? "income" : "outcome",
    };
  }

  @override
  String toString() {
    return [
      "id: $id",
      "name: $name",
      "iconId: $iconId",
      "colorId: $colorId",
      "categoryType: $categoryType",
    ].join(" / ");
  }
}
