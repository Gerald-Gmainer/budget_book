import 'package:flutter_app/data/data.dart';

class AccountDataModel extends DataModel {
  String? name;
  int? iconId;
  int? colorId;

  AccountDataModel({
    int? id,
    this.name,
    this.iconId,
    this.colorId,
  }) : super(id);

  factory AccountDataModel.fromJson(Map<String, dynamic> json) => AccountDataModel(
        id: json['id'],
        name: json['name'],
        iconId: json['icon_id'],
        colorId: json['color_id'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon_id': iconId,
      'color_id': colorId,
    };
  }

  @override
  String toString() {
    return [
      "id: $id",
      "name: $name",
      "iconId: $iconId",
      "colorId: $colorId",
    ].join(" / ");
  }
}
