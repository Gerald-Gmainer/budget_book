import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
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
          builder: (context) => BookingCrudPage(model: settings.arguments as BookingModel),
        );
      case CategoryCrudPage.route:
        return MyCustomRoute(
          builder: (context) => CategoryCrudPage(model: settings.arguments as CategoryModel),
        );
      case BookingListPage.route:
        return MyCustomRoute(
          builder: (context) => BookingListPage(pageModel: settings.arguments as BookingListPageModel),
        );
      case CategoryListPage.route:
        return MyCustomRoute(
          builder: (context) => CategoryListPage(),
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
