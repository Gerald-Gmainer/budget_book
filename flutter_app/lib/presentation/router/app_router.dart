import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/logger.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    BudgetLogger.instance.d("AppRouter, go to ${settings.name}");

    switch (settings.name) {
      case LoginPage.route:
        return MyCustomRoute(
          builder: (context) => const LoginPage(),
        );
      case SignUpPage.route:
        return MyCustomRoute(
          builder: (context) => const SignUpPage(),
        );
      case ForgotPasswordPage.route:
        return MyCustomRoute(
          builder: (context) => const ForgotPasswordPage(),
        );
      case MainPage.route:
        return MyCustomRoute(
          builder: (context) => const MainPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
    }
  }
}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({required WidgetBuilder builder, RouteSettings? settings}) : super(builder: builder, settings: settings);
}
