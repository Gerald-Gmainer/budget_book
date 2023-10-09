import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:collection/collection.dart';

class CategoryConverter {
  List<CategoryModel> fromDataModels(List<CategoryDataModel> dataModels, List<CategoryIconDataModel> icons, List<CategoryColorDataModel> colors) {
    return dataModels.map((dataModel) => fromDataModel(dataModel, icons, colors)).toList();
  }

  CategoryModel fromDataModel(CategoryDataModel dataModel, List<CategoryIconDataModel> icons, List<CategoryColorDataModel> colors) {
    return CategoryModel(
      id: dataModel.id,
      name: dataModel.name,
      iconData: _iconNameFromId(dataModel.iconId, icons),
      iconColor: _iconColorFromId(dataModel.colorId, colors),
      categoryType: dataModel.categoryType,
    );
  }

  IconData? _iconNameFromId(int? iconId, List<CategoryIconDataModel> icons) {
    final iconModel = icons.firstWhereOrNull((iconModel) => iconModel.id == iconId);
    if (iconModel == null) return null;
    return IconData(iconModel.name ?? "unkown");
  }

  IconColor? _iconColorFromId(int? colorId, List<CategoryColorDataModel> colors) {
    final colorModel = colors.firstWhereOrNull((colorModel) => colorModel.id == colorId);
    if (colorModel == null) return null;
    return IconColor(colorModel.code ?? "#FFFFFF");
  }
}
