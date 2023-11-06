import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uni_links/uni_links.dart';
import 'package:provider/provider.dart' as prov;

class SupabaseContainer extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final Widget child;

  const SupabaseContainer({required this.child, required this.navigatorKey});

  @override
  State<SupabaseContainer> createState() => _SupabaseContainerState();
}

class _SupabaseContainerState extends State<SupabaseContainer> with SupabaseDeepLinkingMixin {
  late final StreamSubscription<AuthState> _authSubscription;

  @override
  void initState() {
    _authSubscription = supabase.auth.onAuthStateChange.listen(_onAuthStateChange);
    startDeeplinkObserver();
    super.initState();
    FlutterNativeSplash.remove();
  }

  _onAuthStateChange(AuthState state) {
    final AuthChangeEvent event = state.event;
    final Session? session = state.session;
    switch (event) {
      case AuthChangeEvent.signedOut:
        _onUnauthenticated();
        break;

      case AuthChangeEvent.signedIn:
        _onAuthenticated(session!);
        break;

      case AuthChangeEvent.passwordRecovery:
        _onPasswordRecovery(session!);
        break;

      case AuthChangeEvent.tokenRefreshed:
        _onTokenRefreshed(session!);
        break;

      default:
        BudgetLogger.instance.d("unhandled AuthChangeEvent: $event");
    }
  }

  void _onUnauthenticated() {
    if (mounted) {
      BudgetLogger.instance.d("onUnauthenticated");
    }
  }

  _onAuthenticated(Session session) {
    if (mounted) {
      BudgetLogger.instance.d("onAuthenticated: ${session.user.id}");
      BlocProvider.of<ProfileBloc>(context).add(LoadProfileEvent());
    }
  }

  _onTokenRefreshed(Session session) {
    BudgetLogger.instance.d("onTokenRefreshed: ${session.user.id}");
    BlocProvider.of<ProfileBloc>(context).add(LoadProfileEvent());
  }

  _onPasswordRecovery(Session session) {
    BudgetLogger.instance.d("onPasswordRecovery: ${session.user}");
    widget.navigatorKey.currentState?.pushNamedAndRemoveUntil(ResetPasswordPage.route, (route) => false, arguments: false);
  }

  _onErrorAuthenticating(String message) {
    BudgetLogger.instance.e(message);
    String text = message;
    if (message == "Confirmation Token not found") {
      text = "token not found";
    } else if (message.contains("signature is invalid")) {
      text = "Signature Invalid";
    }
    _showErrorMessage(text);
  }

  _showMessage(String message) {
    final scaffoldContext = prov.Provider.of<ScaffoldProvider>(context, listen: false).scaffoldContext;
    showSnackBar(scaffoldContext, message);
  }

  _showErrorMessage(String message) {
    final scaffoldContext = prov.Provider.of<ScaffoldProvider>(context, listen: false).scaffoldContext;
    showErrorSnackBar(scaffoldContext, message);
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void handleDeeplink(Uri uri) {
    BudgetLogger.instance.d('onReceivedAuthDeeplink: $uri');
    final uriParameters = _parseUriParameters(uri);
    _recoverSessionFromDeeplink(uri, uriParameters['type']);
  }

  _recoverSessionFromDeeplink(Uri uri, String? deepLinkType) async {
    BudgetLogger.instance.d("_recoverSessionFromDeeplink  / type: $deepLinkType");
    try {
      final AuthSessionUrlResponse response = await Supabase.instance.client.auth.getSessionFromUrl(uri);
      if (deepLinkType == 'recovery') {
        _onPasswordRecovery(response.session);
      } else {
        await supabase.auth.refreshSession();
        _onAuthenticated(response.session);
        if (!mounted) {
          BudgetLogger.instance.d("_recoverSessionFromDeeplink not mounted anymore");
          return;
        }
        BudgetLogger.instance.d("_recoverSessionFromDeeplink success!");
        _showMessage("Sign Up success!");
        widget.navigatorKey.currentState?.pushNamedAndRemoveUntil(MainPage.route, (route) => false, arguments: false);
      }
    } on Exception catch (e) {
      _onErrorAuthenticating(e.toString());
    }
  }

  Map<String, String> _parseUriParameters(Uri uri) {
    Uri _uri = uri;
    if (_uri.hasQuery) {
      final decoded = _uri.toString().replaceAll('#', '&');
      _uri = Uri.parse(decoded);
    } else {
      final uriStr = _uri.toString();
      String decoded;
      // %23 is the encoded of #hash
      // support custom redirect to on flutter web
      if (uriStr.contains('/#%23')) {
        decoded = uriStr.replaceAll('/#%23', '/?');
      } else if (uriStr.contains('/#/')) {
        decoded = uriStr.replaceAll('/#/', '/').replaceAll('%23', '?');
      } else {
        decoded = uriStr.replaceAll('#', '?');
      }
      _uri = Uri.parse(decoded);
    }
    return _uri.queryParameters;
  }

  @override
  void onErrorReceivingDeeplink(String message) {
    BudgetLogger.instance.e('onErrorReceivingDeeplink: $message');
    _onErrorAuthenticating(message);
  }
}

mixin SupabaseDeepLinkingMixin<T extends StatefulWidget> on State<T> {
  StreamSubscription? _sub;

  void startDeeplinkObserver() {
    Supabase.instance.log('***** SupabaseDeepLinkingMixin startAuthObserver');
    _handleIncomingLinks();
    _handleInitialUri();
  }

  void stopDeeplinkObserver() {
    Supabase.instance.log('***** SupabaseDeepLinkingMixin stopAuthObserver');
    if (_sub != null) _sub?.cancel();
  }

  /// Handle incoming links - the ones that the app will recieve from the OS
  /// while already started.
  void _handleIncomingLinks() {
    if (!kIsWeb) {
      // It will handle app links while the app is already started - be it in
      // the foreground or in the background.
      _sub = uriLinkStream.listen(
        (Uri? uri) {
          if (mounted && uri != null) {
            handleDeeplink(uri);
          }
        },
        onError: (Object err) {
          if (!mounted) return;
          onErrorReceivingDeeplink(err.toString());
        },
      );
    }
  }

  /// Handle the initial Uri - the one the app was started with
  ///
  /// **ATTENTION**: `getInitialLink`/`getInitialUri` should be handled
  /// ONLY ONCE in your app's lifetime, since it is not meant to change
  /// throughout your app's life.
  ///
  /// We handle all exceptions, since it is called from initState.
  Future<void> _handleInitialUri() async {
    // if (!SupabaseAuth.instance.shouldHandleInitialDeeplink()) return;

    try {
      final uri = await getInitialUri();
      if (mounted && uri != null) {
        handleDeeplink(uri);
      }
    } on PlatformException {
      // Platform messages may fail but we ignore the exception
    } on FormatException catch (err) {
      if (!mounted) return;
      onErrorReceivingDeeplink(err.message);
    }
  }

  /// Callback when deeplink receiving succeeds
  void handleDeeplink(Uri uri);

  /// Callback when deeplink receiving throw error
  void onErrorReceivingDeeplink(String message);
}
