import 'package:collection/collection.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/utils/utils.dart';

class ProfileConverter {
  ProfileModel fromProfileData(ProfileDataModel dataModel) {
    return ProfileModel(
      name: dataModel.name!,
      email: dataModel.email,
      avatarUrl: dataModel.avatarUrl,
    );
  }

  ProfileSettingModel fromProfileSettingData(ProfileSettingDataModel dataModel, List<CurrencyDataModel> currencies) {
    return ProfileSettingModel(
      currency: _currencyFromId(dataModel.currencyId, currencies),
    );
  }

  CurrencyModel _currencyFromId(int? id, List<CurrencyDataModel> currencies) {
    final currencyModel = currencies.firstWhereOrNull((model) => model.id == id);
    if (currencyModel == null) {
      throw "cannot convert currencyId $id";
    }
    return CurrencyModel(
      id: currencyModel.id!,
      name: currencyModel.name!,
      decimalPrecision: currencyModel.decimalPrecision,
      isUnitPositionFront: currencyModel.isUnitPositionFront,
      symbol: currencyModel.symbol!,
    );
  }
}
