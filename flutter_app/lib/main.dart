import 'package:flutter/material.dart';
import 'package:flutter_app/utils/utils.dart';

import 'presentation/presentation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SupabaseContainer(
      child: MaterialApp(
        title: 'Budget book',
        theme: _createTheme(context),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        navigatorKey: _navigatorKey,
        onGenerateRoute: _appRouter.onGenerateRoute,
        home: Container(),
      ),
    );
  }

  ThemeData _createTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: "Noto Sans JP",
      primaryColor: AppColors.accentColor,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: AppColors.accentColor,
        unselectedItemColor: AppColors.secondaryTextColor,
      ),
      textTheme: const TextTheme(
        headline1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.accentColor),
        headline2: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: AppColors.secondaryTextColor),
        headline3: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
        bodyText1: TextStyle(fontSize: 16, color: AppColors.primaryTextColor, fontWeight: FontWeight.normal),
        bodyText2: TextStyle(fontSize: 15, color: AppColors.secondaryTextColor, fontWeight: FontWeight.normal),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: AppColors.accentColor, foregroundColor: AppColors.primaryTextColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(AppColors.primaryTextColor),
          backgroundColor: MaterialStateProperty.all(AppColors.secondaryColor),
        ),
      ),
    );
  }
}
