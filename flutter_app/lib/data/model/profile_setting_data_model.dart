import '../data.dart';

class ProfileSettingDataModel extends DataModel {
  int? currencyId;

  ProfileSettingDataModel({
    int? id,
    required this.currencyId,
  }) : super(id);

  factory ProfileSettingDataModel.fromJson(Map<String, dynamic> json) => ProfileSettingDataModel(
        id: json['id'],
        currencyId: json['currency_id'],
      );

  @override
  String toString() {
    return "ProfileSettingDataModel currencyId: $currencyId";
  }
}
