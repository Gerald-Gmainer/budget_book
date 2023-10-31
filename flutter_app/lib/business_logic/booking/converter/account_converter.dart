import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';

class AccountConverter {
  List<AccountModel> fromDataModels(List<AccountDataModel> dataModels) {
    return dataModels
        .map(
          (e) => AccountModel(
            id: e.id,
            name: e.name,
          ),
        )
        .toList();
  }
}
