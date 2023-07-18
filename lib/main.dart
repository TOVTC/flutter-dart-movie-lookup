import 'package:flutter/material.dart';
import 'package:flutter_dart_movie_lookup/screens/homepage.dart';
import 'package:flutter_dart_movie_lookup/screens/search_results.dart';

final theme = ThemeData(
  useMaterial3: true,
);

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const SearchResults(searchTerm: 'test'),
    );
  }
}
