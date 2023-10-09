import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';

class CategoryModel {
  int? id;
  String? name;
  IconData? iconData;
  IconColor? iconColor;
  CategoryType categoryType;

  CategoryModel.empty({required this.categoryType});

  CategoryModel({
    this.id,
    this.name,
    this.iconData,
    this.iconColor,
    required this.categoryType,
  });
}
