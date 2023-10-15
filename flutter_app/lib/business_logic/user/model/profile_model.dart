class ProfileModel {
  String name;
  String? email;
  String? avatarUrl;

  ProfileModel({
    required this.name,
    required this.email,
    this.avatarUrl,
  });
}
