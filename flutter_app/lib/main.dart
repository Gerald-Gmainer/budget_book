import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/presentation/root/supabase_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'presentation/presentation.dart';
import 'presentation/root/internet_connectivity.dart';
import 'utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await EasyLocalization.ensureInitialized();
  // await dotenv.load(fileName: kReleaseMode ? ".env.prod" : ".env.dev");
  await dotenv.load(fileName: ".env.prod");
  // await dotenv.load(fileName: ".env.dev");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? "",
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? "",
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => ScaffoldProvider(),
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('de')],
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        child: MyApp(),
      ),
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
    final profileBloc = ProfileBloc(_userRepo);

    return InternetConnectivity(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(create: (context) => LoginBloc(_userRepo)),
          BlocProvider<ProfileBloc>(create: (context) => profileBloc),
          BlocProvider<SignUpBloc>(create: (context) => SignUpBloc(_userRepo)),
          BlocProvider<LanguageBloc>(create: (context) => LanguageBloc(_userRepo)),
          // --
          BlocProvider<GraphViewBloc>(create: (context) => GraphViewBloc(_bookingRepo)),
          BlocProvider<BookingCrudBloc>(create: (context) => BookingCrudBloc(_bookingRepo)),
          BlocProvider<CalculatorBloc>(create: (context) => CalculatorBloc()),
          BlocProvider<CategoryListBloc>(create: (context) => CategoryListBloc(_bookingRepo)),
          BlocProvider<CategoryIconBloc>(create: (context) => CategoryIconBloc(_bookingRepo)),
          BlocProvider<CategoryCrudBloc>(create: (context) => CategoryCrudBloc(_bookingRepo)),
          BlocProvider<SuggestionBloc>(create: (context) => SuggestionBloc(_bookingRepo, _userRepo)),
        ],
        child: SupabaseContainer(
          navigatorKey: _navigatorKey,
          child: MaterialApp(
            title: 'Budget book',
            theme: _createTheme(context),
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            navigatorKey: _navigatorKey,
            onGenerateRoute: _appRouter.onGenerateRoute,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
          ),
        ),
      ),
    );
  }

  ThemeData _createTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      // fontFamily: GoogleFonts.raleway().fontFamily,
      fontFamily: GoogleFonts.poppins().fontFamily,
      // fontFamily: GoogleFonts.notoSans().fontFamily,
      // fontFamily: GoogleFonts.arimo().fontFamily,
      primaryColor: AppColors.accentColor,
      tabBarTheme: TabBarTheme(
        labelPadding: EdgeInsets.symmetric(vertical: 8),
        indicator: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.accentColor, width: 4.0)),
        ),
      ),
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
      cardTheme: CardTheme(color: AppColors.cardColor),
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
