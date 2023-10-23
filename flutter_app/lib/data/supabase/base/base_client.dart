import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseClient {
  static const bool logSession = false;

  Future<void> checkToken() async {
    if (!ConnectivitySingleton.instance.isConnected()) {
      return;
    }
    if (supabase.auth.currentUser == null || supabase.auth.currentSession == null) {
      return;
    }
    Session session = supabase.auth.currentSession!;
    if (logSession) {
      _logSession(session);
    }
    if ((session.expiresAt! - 5) < (DateTime.now().millisecondsSinceEpoch / 1000).round()) {
      BudgetLogger.instance.i("REFRESH TOKEN");
      await supabase.auth.refreshSession();
    }
  }

  void _logSession(Session session) {
    DateTime expiresAt = DateTime.fromMillisecondsSinceEpoch(session.expiresAt! * 1000);
    DateTime now = DateTime.now();
    var msg = [
      "session: ",
      "expiresIn: ${session.expiresIn}",
      "expiresAt: ${session.expiresAt == null ? "NULL" : DateTimeConverter.toYYYYMMdd(expiresAt)}",
      "now: ${DateTimeConverter.toYYYYMMdd(now)}",
      "refreshToken: ${session.refreshToken}",
    ];
    BudgetLogger.instance.d(msg.join("\n"));
  }

  String getUserId() {
    if (supabase.auth.currentUser == null) {
      throw "BaseClient getUserId: currentUser is NULL";
    }
    return supabase.auth.currentUser!.id;
  }

  int getProfileId() {
    if (supabase.auth.currentUser == null) {
      throw "BaseClient getProfileId: currentUser is NULL";
    }
    final User user = supabase.auth!.currentUser!;
    if (user.userMetadata == null || user.userMetadata!.isEmpty || user.userMetadata!["profile_id"] == null) {
      throw "BaseClient getProfileId: userMetadata is NULL";
    }

    return user.userMetadata!["profile_id"]! as int;
  }
}
