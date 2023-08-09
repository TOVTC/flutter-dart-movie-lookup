import 'package:flutter/material.dart';
import 'package:flutter_dart_movie_lookup/screens/homepage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dart_movie_lookup/providers/locale_provider.dart';

final theme = ThemeData(
  useMaterial3: true,
);

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LocalJsonLocalization.delegate.directories = ['lib/i18n'];

    return MaterialApp(
      locale: ref.watch(localeProvider),
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
      home: const Homepage(),
    );
  }
}
