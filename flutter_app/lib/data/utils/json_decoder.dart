class JsonDecoder {
  static DateTime? decodeDateTime(String? value) {
    return value == null ? null : DateTime.parse(value);
  }

  static int? decodeInt(String? value) {
    return value == null ? null : int.parse(value);
  }

  static double? decodeDouble(String? value) {
    return value == null ? null : double.parse(value);
  }
}