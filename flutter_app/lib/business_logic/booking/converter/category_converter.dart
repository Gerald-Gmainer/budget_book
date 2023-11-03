import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:collection/collection.dart';
import 'package:flutter_app/utils/utils.dart';

class CategoryConverter {
  List<CategoryModel> fromDataModels(List<CategoryDataModel> dataModels, IconCacheModel iconCache) {
    return dataModels.map((dataModel) => fromDataModel(dataModel, iconCache.categoryIcons, iconCache.categoryColors)).toList();
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

  IconDataModel? _iconNameFromId(int? iconId, List<CategoryIconDataModel> icons) {
    final iconModel = icons.firstWhereOrNull((iconModel) => iconModel.id == iconId);
    if (iconModel == null || iconModel.name == null) {
      BudgetLogger.instance.i("cannot convert iconId $iconId");
      return null;
    }
    return IconDataModel(id: iconModel.id!, name: iconModel.name!);
  }

  IconColorModel? _iconColorFromId(int? colorId, List<CategoryColorDataModel> colors) {
    final colorModel = colors.firstWhereOrNull((colorModel) => colorModel.id == colorId);
    if (colorModel == null) {
      return null;
    }
    return IconColorModel(id: colorModel.id!, code: colorModel.code!);
  }

  List<IconDataModel> fromIconDataModels(List<CategoryIconDataModel> models) {
    return models.map((e) => IconDataModel(id: e.id!, name: e.name!)).toList();
  }

  List<IconColorModel> fromColorDataModels(List<CategoryColorDataModel> models) {
    return models.map((e) => IconColorModel(id: e.id!, code: e.code!)).toList();
  }

  CategoryDataModel toDataModel(CategoryModel oldModel) {
    return CategoryDataModel(
      id: oldModel.id,
      name: oldModel.name,
      iconId: oldModel.iconData?.id,
      colorId: oldModel.iconColor?.id,
      categoryType: oldModel.categoryType,
    );
  }
}
