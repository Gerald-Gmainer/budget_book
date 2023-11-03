import 'package:collection/collection.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/utils/utils.dart';

class AccountConverter {
  List<AccountModel> fromDataModels(List<AccountDataModel> dataModels, IconCacheModel iconCache) {
    return dataModels.map((dataModel) => fromDataModel(dataModel, iconCache.accountIcons, iconCache.accountColors)).toList();
  }

  AccountModel fromDataModel(AccountDataModel dataModel, List<AccountIconDataModel> icons, List<AccountIconColorModel> colors) {
    return AccountModel(
      id: dataModel.id,
      name: dataModel.name,
      iconData: _iconNameFromId(dataModel.iconId, icons),
      iconColor: _iconColorFromId(dataModel.colorId, colors),
    );
  }

  IconDataModel? _iconNameFromId(int? iconId, List<AccountIconDataModel> icons) {
    final iconModel = icons.firstWhereOrNull((iconModel) => iconModel.id == iconId);
    if (iconModel == null || iconModel.name == null) {
      BudgetLogger.instance.i("cannot convert iconId $iconId");
      return null;
    }
    return IconDataModel(id: iconModel.id!, name: iconModel.name!);
  }

  IconColorModel? _iconColorFromId(int? colorId, List<AccountIconColorModel> colors) {
    final colorModel = colors.firstWhereOrNull((colorModel) => colorModel.id == colorId);
    if (colorModel == null) {
      return null;
    }
    return IconColorModel(id: colorModel.id!, code: colorModel.code!);
  }
}
