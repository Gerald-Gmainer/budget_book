import 'base/data_model.dart';

class AccountIconDataModel extends DataModel {
  String? name;

  AccountIconDataModel({int? id, this.name}) : super(id);

  factory AccountIconDataModel.fromJson(Map<String, dynamic> json) => AccountIconDataModel(
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
