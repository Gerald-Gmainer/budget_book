import 'package:flutter_app/data/data.dart';

class CurrencyDataModel extends DataModel {
  String? name;
  int? decimalPrecision;
  String? symbol;

  CurrencyDataModel({int? id, this.name, this.decimalPrecision, this.symbol}) : super(id);

  factory CurrencyDataModel.fromJson(Map<String, dynamic> json) => CurrencyDataModel(
        id: json['id'],
        name: json['name'],
        decimalPrecision: json['decimal_precision'],
        symbol: json['symbol'],
      );

  @override
  String toString() {
    return [
      "id: $id",
      "name: $name",
    ].join(" / ");
  }
}
