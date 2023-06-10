import 'package:intl/intl.dart';

class CurrencyConverter {
  static String format(double value) {
    final formatCurrency = NumberFormat.currency(locale: 'ja_JP', symbol: '¥');
    return formatCurrency.format(value);
  }
}
