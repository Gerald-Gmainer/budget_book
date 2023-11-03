import 'package:flutter_app/business_logic/business_logic.dart';

class AccountModel {
  int? id;
  String? name;
  IconDataModel? iconData;
  IconColorModel? iconColor;

  AccountModel.empty()
      : id = null,
        name = null;

  AccountModel({
    required this.id,
    required this.name,
    required this.iconData,
    required this.iconColor,
  });

  @override
  bool operator ==(Object other) => identical(this, other) || other is AccountModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return "AccountModel id: $id /  name: $name / icon: ${iconData?.name} / color: ${iconColor?.code}";
  }
}
