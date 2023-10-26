import '../data.dart';

class ProfileDataModel extends DataModel {
  String? name;
  String? email;
  String? avatarUrl;
  int? currencyId;
  CurrencyDataModel? currency;

  ProfileDataModel({
    int? id,
    this.name,
    this.email,
    this.avatarUrl,
    this.currencyId,
    this.currency,
  }) : super(id);

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) => ProfileDataModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        avatarUrl: json['avatar_url'],
        currencyId: json['currency_id'],
        currency: CurrencyDataModel.fromJson(json['currency']),
      );

  @override
  String toString() {
    return "ProfileDataModel name: $name / avatarUrl: $avatarUrl";
  }
}
