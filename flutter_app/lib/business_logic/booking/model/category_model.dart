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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CategoryModel && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }

  @override
  String toString() {
    return "CategoryModel id: $id / name: $name / icon: ${iconData?.name} / color: ${iconColor?.code} / categoryType: $categoryType";
  }
}
