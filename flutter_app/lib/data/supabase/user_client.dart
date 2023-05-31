import 'package:flutter_app/utils/utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserClient {
  static const String callbackUrl = "com.gerald.gmainer://budgetbook/login-callback";

  Future<bool> googleLogin() async {
    final bool response = await supabase.auth.signInWithOAuth(
      Provider.google,
      redirectTo: callbackUrl,
    );
    return response;
  }

  Future<bool> credentialsLogin(String email, String password) async {
    final AuthResponse response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return response.session != null;
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
  }
}
