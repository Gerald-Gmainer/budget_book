import 'package:flutter_app/data/data.dart';

class AccountIconColorModel extends DataModel {
  String? code;

  AccountIconColorModel({int? id, this.code}) : super(id);

  factory AccountIconColorModel.fromJson(Map<String, dynamic> json) => AccountIconColorModel(
        id: json['id'],
        code: json['code'],
      );

  @override
  String toString() {
    return [
      "id: $id",
      "code: $code",
    ].join(" / ");
  }
}
