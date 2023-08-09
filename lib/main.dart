import 'package:flutter/material.dart';
import 'package:flutter_dart_movie_lookup/screens/homepage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';
import 'dart:io';

final theme = ThemeData(
  useMaterial3: true,
);

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  Locale _locale = Locale(
      Platform.localeName.split('_')[0], Platform.localeName.split('_')[1]);

  void changeLocale() {
    setState(() {
      _locale == const Locale('en', 'US')
          ? _locale = const Locale('es', 'ES')
          : _locale = const Locale('en', 'US');
    });
  }

  @override
  Widget build(BuildContext context) {
    LocalJsonLocalization.delegate.directories = ['lib/i18n'];
    return MaterialApp(
      locale: _locale,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        LocalJsonLocalization.delegate
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('es', 'ES'),
      ],
      theme: theme.copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(100, 69, 88, 111),
        ),
      ),
      home: Homepage(setLocale: changeLocale),
    );
  }
}
