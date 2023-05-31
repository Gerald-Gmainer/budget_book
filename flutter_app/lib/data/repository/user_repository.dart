import 'package:flutter_app/data/data.dart';

class UserRepository {
  final UserClient _client = UserClient();

  Future<bool> googleLogin() async {
    return await _client.googleLogin();
  }

  Future<bool> credentialsLogin(String email, String password) async {
    return await _client.credentialsLogin(email, password);
  }
}
