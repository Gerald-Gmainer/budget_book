import 'package:intl/intl.dart';

class JsonEncoder {
  static String? encodeDateTime(DateTime? value) {
    if (value == null) return null;
    // final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
    // return dateFormatter.format(value);
    return value.toIso8601String();
  }
}
