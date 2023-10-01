import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'presentation/presentation.dart';
import 'utils/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? "",
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? "",
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => ScaffoldProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  final UserRepository _userRepo = UserRepository();
  final BookingRepository _bookingRepo = BookingRepository();

  MyApp({Key? key}) : super(key: key) {
    if (!kReleaseMode) {
      KeepScreenOn.turnOn();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SupabaseContainer(
      navigatorKey: _navigatorKey,
      child: InternetConnectivity(
        child: MultiBlocProvider(
          providers: [
            BlocProvider<LoginBloc>(create: (context) => LoginBloc(_userRepo)),
            BlocProvider<SignUpBloc>(create: (context) => SignUpBloc(_userRepo)),
            BlocProvider<MainPaginatorBloc>(create: (context) => MainPaginatorBloc(_bookingRepo)),
            BlocProvider<BookingCrudBloc>(create: (context) => BookingCrudBloc(_bookingRepo)),
            BlocProvider<CalculatorBloc>(create: (context) => CalculatorBloc()),
            BlocProvider<CategoryListBloc>(create: (context) => CategoryListBloc(_bookingRepo)),
          ],
          child: MaterialApp(
            title: 'Budget book',
            theme: _createTheme(context),
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            navigatorKey: _navigatorKey,
            onGenerateRoute: _appRouter.onGenerateRoute,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
            ],
          ),
        ),
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
