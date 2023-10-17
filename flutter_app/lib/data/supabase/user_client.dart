import 'package:flutter_app/utils/utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'base/base_client.dart';

class UserClient extends BaseClient {
  static const String callbackUrl = "com.gmainer.budgetbook://login-callback";

  Future<bool> googleLogin() async {
    final bool response = await supabase.auth.signInWithOAuth(Provider.google, redirectTo: callbackUrl);
    return response;
  }

  Future<bool> credentialsLogin(String email, String password) async {
    final AuthResponse response = await supabase.auth.signInWithPassword(email: email, password: password);
    return response.session != null;
  }

  Future<void> signUp(String email, String password) async {
    await supabase.auth.signUp(email: email, password: password, emailRedirectTo: callbackUrl);
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
  }
}
