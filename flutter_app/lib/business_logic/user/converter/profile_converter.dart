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
      currency: _convertCurrency(dataModel.currency),
    );
  }

  CurrencyModel _convertCurrency(CurrencyDataModel? old) {
    if (old == null) {
      throw "cannot convert currency from NULL";
    }
    return CurrencyModel(
      id: old.id!,
      name: old.name!,
      decimalPrecision: old.decimalPrecision,
      isUnitPositionFront: old.isUnitPositionFront,
      symbol: old.symbol!,
    );
  }
}
