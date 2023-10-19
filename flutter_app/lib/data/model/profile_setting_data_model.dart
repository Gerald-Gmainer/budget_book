import '../data.dart';

class ProfileSettingDataModel extends DataModel {
  int? currencyId;
  CurrencyDataModel? currency;

  ProfileSettingDataModel({
    int? id,
    required this.currencyId,
    this.currency,
  }) : super(id);

  factory ProfileSettingDataModel.fromJson(Map<String, dynamic> json) => ProfileSettingDataModel(
        id: json['id'],
        currencyId: json['currency_id'],
        currency: CurrencyDataModel.fromJson(json['currency']),
      );

  @override
  String toString() {
    return "ProfileSettingDataModel currencyId: $currencyId";
  }
}
