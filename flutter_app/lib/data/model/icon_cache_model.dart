import 'package:flutter_app/data/data.dart';

class IconCacheModel {
  final List<CategoryIconDataModel> categoryIcons;
  final List<CategoryColorDataModel> categoryColors;
  final List<AccountIconDataModel> accountIcons;
  final List<AccountIconColorModel> accountColors;

  IconCacheModel({
    required this.categoryIcons,
    required this.categoryColors,
    required this.accountIcons,
    required this.accountColors,
  });
}
