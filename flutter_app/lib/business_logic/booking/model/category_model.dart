import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/enum/enum.dart';

class CategoryModel {
  int? id;
  String? name;
  IconDataModel? iconData;
  IconColorModel? iconColor;
  CategoryType categoryType;

  CategoryModel.empty({required this.categoryType});

  CategoryModel({
    required this.id,
    required this.name,
    required this.iconData,
    required this.iconColor,
    required this.categoryType,
  });
}
