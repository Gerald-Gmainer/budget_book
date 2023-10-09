import 'package:flutter_app/data/data.dart';

class CategoryIconDataModel extends DataModel {
  String? name;

  CategoryIconDataModel({int? id, this.name}) : super(id);

  factory CategoryIconDataModel.fromJson(Map<String, dynamic> json) => CategoryIconDataModel(
    id: json['id'],
    name: json['name'],
  );

  @override
  String toString() {
    return [
      "id: $id",
      "name: $name",
    ].join(" / ");
  }
}
