import 'package:flutter_app/data/data.dart';

class CurrencyDataModel extends DataModel {
  String? name;
  int decimalPrecision;
  String? symbol;
  bool isUnitPositionFront;

  CurrencyDataModel({
    int? id,
    this.name,
    this.decimalPrecision = 2,
    this.symbol,
    this.isUnitPositionFront = true,
  }) : super(id);

  factory CurrencyDataModel.fromJson(Map<String, dynamic> json) => CurrencyDataModel(
        id: json['id'],
        name: json['name'],
        decimalPrecision: json['decimal_precision'],
        symbol: json['symbol'],
        isUnitPositionFront: json['unit_position_front'],
      );

  @override
  String toString() {
    return [
      "id: $id",
      "name: $name",
    ].join(" / ");
  }
}
