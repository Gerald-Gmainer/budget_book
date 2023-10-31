import 'package:flutter_app/data/data.dart';

class AccountDataModel extends DataModel {
  String? name;

  AccountDataModel({
    int? id,
    required this.name,
  }) : super(id);

  factory AccountDataModel.fromJson(Map<String, dynamic> json) => AccountDataModel(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() {
    return [
      "id: $id",
      "name: $name",
    ].join(" / ");
  }
}
