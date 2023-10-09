import 'package:flutter_app/data/data.dart';

class CategoryColorDataModel extends DataModel {
  String? code;

  CategoryColorDataModel({int? id, this.code}) : super(id);

  factory CategoryColorDataModel.fromJson(Map<String, dynamic> json) => CategoryColorDataModel(
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
