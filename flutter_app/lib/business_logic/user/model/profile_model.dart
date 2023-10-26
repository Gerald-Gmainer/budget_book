import 'package:flutter_app/business_logic/business_logic.dart';

class ProfileModel {
  String name;
  String? email;
  String? avatarUrl;
  CurrencyModel currency;

  ProfileModel({
    required this.name,
    required this.email,
    this.avatarUrl,
    required this.currency,
  });
}
