class IconColorModel {
  final int id;
  final String code;

  IconColorModel({
    required this.id,
    required this.code,
  });

  @override
  bool operator ==(Object other) => identical(this, other) || other is IconColorModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
