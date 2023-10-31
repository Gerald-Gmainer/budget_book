class AccountModel {
  int? id;
  String? name;

  AccountModel.empty()
      : id = null,
        name = null;

  AccountModel({
    required this.id,
    required this.name,
  });

  @override
  String toString() {
    return "AccountModel id: $id /  name: $name ";
  }
}
