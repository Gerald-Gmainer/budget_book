import 'package:flutter/material.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/logger.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    BudgetLogger.instance.d("AppRouter, go to ${settings.name}");

    switch (settings.name) {
      case LoginPage.route:
        return MyCustomRoute(
          builder: (context) => LoginPage(),
        );
      case SignUpPage.route:
        return MyCustomRoute(
          builder: (context) => SignUpPage(),
        );
      case ForgotPasswordPage.route:
        return MyCustomRoute(
          builder: (context) => ForgotPasswordPage(),
        );
      case ResetPasswordPage.route:
        return MyCustomRoute(
          builder: (context) => ResetPasswordPage(),
        );
      case MainPage.route:
        return MyCustomRoute(
          builder: (context) => MainPage(),
        );
      case SettingsPage.route:
        return MyCustomRoute(
          builder: (context) => SettingsPage(),
        );
      case BookingCrudPage.route:
        return MyCustomRoute(
          builder: (context) => BookingCrudPage(bookingModel: settings.arguments as BookingModel),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );
    }
  }
}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({required WidgetBuilder builder, RouteSettings? settings}) : super(builder: builder, settings: settings);
}
