class IconDataModel {
  final int id;
  final String name;

  IconDataModel({
    required this.id,
    required this.name,
  });

  @override
  bool operator ==(Object other) => identical(this, other) || other is IconDataModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
