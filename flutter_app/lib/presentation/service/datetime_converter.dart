import 'package:intl/intl.dart';

class DateTimeConverter {
  static String toYYYYMMdd(DateTime? date) {
    if (date == null) {
      return "";
    }
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String toMMMMdd(DateTime? date) {
    if (date == null) {
      return "";
    }
    return DateFormat('MMMM dd').format(date);
  }

  static String toMMMM(DateTime? date) {
    if (date == null) {
      return "";
    }
    return DateFormat('MMMM').format(date);
  }

  static String toMMMMYYYY(DateTime? date) {
    if (date == null) {
      return "";
    }
    return DateFormat('MMMM yyyy').format(date);
  }

  static String toMMdd(DateTime? date) {
    if (date == null) {
      return "";
    }
    return DateFormat('MM/dd').format(date);
  }

  static String toEEEEdMMMM(DateTime? date) {
    if (date == null) {
      return "";
    }
    return DateFormat('EEEE, d MMMM').format(date);
  }

  static String toEEEEdMMMMYYY(DateTime? date) {
    if (date == null) {
      return "";
    }
    return DateFormat('EEEE, d MMMM yyyy').format(date);
  }
}
