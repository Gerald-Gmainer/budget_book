import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uni_links/uni_links.dart';

class SupabaseContainer extends StatefulWidget {
  final Widget child;
  const SupabaseContainer({super.key, required this.child});

  @override
  State<SupabaseContainer> createState() => _SupabaseContainerState();
}

class _SupabaseContainerState extends State<SupabaseContainer> with SupabaseDeepLinkingMixin {
  late final StreamSubscription<AuthState> _authSubscription;
  bool? _isLoggedIn;

  @override
  void initState() {
    _authSubscription = supabase.auth.onAuthStateChange.listen(_onAuthStateChange);
    super.initState();
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
        break;

      default:
      // _logger.d("unhandled AuthChangeEvent: $event");
    }
  }

  void _onUnauthenticated() {
    if (_isLoggedIn == false) {
      return;
    }
    _isLoggedIn = false;
    if (mounted) {
      // _logger.d("onUnauthenticated");
      // BlocProvider.of<LoggedInCubit>(context).logOut();
      // BlocProvider.of<ResultBloc>(context).add(DeleteAllLocalResultsEvent());
      // BlocProvider.of<ResumeBloc>(context).add(ClearResumeEvent());
      // BlocProvider.of<TrackingBloc>(context).add(TrackingCancelEvent());
    }
  }

  void _onAuthenticated(Session session) {
    if (_isLoggedIn == true) {
      return;
    }
    _isLoggedIn = true;
    if (mounted) {
      // _logger.d("onAuthenticated: ${session.user.id}");
      // BlocProvider.of<LoggedInCubit>(context).logIn();
      // BlocProvider.of<ProfileBloc>(context).add(LoadProfileEvent(userId: session.user.id));
      // BlocProvider.of<ApiCheckCubit>(context).checkApi();
      // BlocProvider.of<AutoLogoutCubit>(context).onTap();
    }
  }

  _onPasswordRecovery(Session session) {
    // _logger.d("onPasswordRecovery: ${session.user}");
    // Navigator.of(context).pushNamedAndRemoveUntil(ResetPasswordPage.route, (route) => false, arguments: false);
  }

  _onErrorAuthenticating(String message) {
    String text = message;
    // if (message == "Confirmation Token not found") {
    //   text = AppStrings.errorTokenNotFound;
    // } else if (message.contains("signature is invalid")) {
    //   text = AppStrings.errorSignatureInvalid;
    // }

    // BlocProvider.of<SupabaseMessageCubit>(context).showDialog(AppStrings.labelError, text);
    // BlocProvider.of<LoggedInCubit>(context).logOut();
    // BlocProvider.of<ResultBloc>(context).add(DeleteAllLocalResultsEvent());
    // BlocProvider.of<ProfileBloc>(context).add(RemoveProfileEvent());
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
    // _logger.d('onReceivedAuthDeeplink: $uri');
    final uriParameters = _parseUriParameters(uri);
    _recoverSessionFromDeeplink(uri, uriParameters['type']);
  }

  _recoverSessionFromDeeplink(Uri uri, String? deepLinkType) async {
    // _logger.d("_recoverSessionFromDeeplink  / type: $deepLinkType");
    try {
      final AuthSessionUrlResponse response = await Supabase.instance.client.auth.getSessionFromUrl(uri);
      if (deepLinkType == 'recovery') {
        _onPasswordRecovery(response.session);
      } else {
        _onAuthenticated(response.session);
        if (!mounted) return;
        // BlocProvider.of<SupabaseMessageCubit>(context).showSnack(AppStrings.successSnackLoginMessage);
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
    // _logger.e('onErrorReceivingDeeplink: $message');
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
