import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/presentation.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    // _logger.d("AppRouter, go to ${settings.name}");

    switch (settings.name) {
      case LoginPage.route:
        return MyCustomRoute(
          builder: (context) => const LoginPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
    }
  }
}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({required WidgetBuilder builder, RouteSettings? settings}) : super(builder: builder, settings: settings);
}
