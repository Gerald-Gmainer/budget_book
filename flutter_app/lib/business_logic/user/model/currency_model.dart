class CurrencyModel {
  final int id;
  final String name;
  final int decimalPrecision;
  final bool isUnitPositionFront;
  final String symbol;

  CurrencyModel({
    required this.id,
    required this.name,
    required this.decimalPrecision,
    required this.isUnitPositionFront,
    required this.symbol,
  });

  @override
  String toString() {
    return "CurrencyModel $name / $symbol";
  }
}
