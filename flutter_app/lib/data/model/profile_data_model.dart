import '../data.dart';

class ProfileDataModel extends DataModel {
  String? name;
  String? avatarUrl;

  ProfileDataModel({
    int? id,
    this.name,
    this.avatarUrl,
  }) : super(id);

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) => ProfileDataModel(
        id: json['id'],
        name: json['name'],
        avatarUrl: json['avatar_url'],
      );

  @override
  String toString() {
    return "ProfileDataModel name: $name / avatarUrl: $avatarUrl";
  }
}
