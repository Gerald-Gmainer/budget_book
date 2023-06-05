import 'package:intl/intl.dart';

class DateTimeConverter {
  static final _dateFormat = DateFormat('yyyy-MM-dd');

  static String toDateString(DateTime? date) {
    if (date == null) {
      return "";
    }
    return _dateFormat.format(date);
  }
}
