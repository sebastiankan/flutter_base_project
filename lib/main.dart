import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mizban/application/shared_preferences.dart';
import 'package:mizban/screen/main_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Brightness _brightness = await UserDefaults.shared.getAppearance();

  String _locale = await UserDefaults.shared.getCurrentLocale();
  if (_locale == "") {
    _locale = "en-US";
  };
  String _lang = _locale.split('-')[0];
  String _country = _locale.split('-')[1];

  runApp(EasyLocalization(
    child: MyApp(_brightness),
    supportedLocales: [Locale('en', 'US'), Locale('fa', 'IR')],
    path: 'assets/translations',
    fallbackLocale: Locale(_lang, _country),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  late Brightness _brightness;

  MyApp(Brightness brightness) {
    _brightness = brightness;
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    String fontFamily = context.locale.languageCode == 'fa'
        ? 'IRANYekanMobile'
        : 'SF-Pro-Display';

    ThemeData darkTheme = ThemeData(
        // textTheme: TextTheme(bodyText1: TextStyle(color: Colors.yellow)),
        backgroundColor: Colors.grey[850]!,
        primaryIconTheme: IconThemeData(color: Colors.purpleAccent),
        bottomAppBarColor: Colors.grey[900]!,
        accentColor: Colors.purpleAccent,
        cardColor: Colors.purple,
        brightness: Brightness.dark,
        dialogBackgroundColor: Colors.grey[900]!,
        fontFamily: fontFamily,
        primarySwatch: Colors.purple
        );

    ThemeData lightTheme = ThemeData(
      bottomAppBarColor: Colors.deepPurple,
        backgroundColor: Colors.white,
        cardColor: Colors.deepPurple,
        brightness: Brightness.light,
        fontFamily: fontFamily,
        primarySwatch: Colors.deepPurple);

    final themeCollection = ThemeCollection(
      themes: {
        AppThemes.Light: lightTheme,
        AppThemes.Dark: darkTheme,
      },
      fallbackTheme: lightTheme,
    );

    return DynamicTheme(
        themeCollection: themeCollection,
        defaultThemeId: widget._brightness == Brightness.light ? AppThemes.Light : AppThemes.Dark, // optional, default id is 0
        builder: (context, theme) {
          return MaterialApp(
            title: 'Flutter Demo',
            supportedLocales: [Locale('en', 'US'), Locale('fa', 'IR')],
            localizationsDelegates: context.localizationDelegates,
            debugShowCheckedModeBanner: false,
            locale: context.locale,
            theme: theme,
            home: MainView(),
          );
        });
  }
}

class AppThemes {
  static const int Light = 0;
  static const int Dark = 1;
}
