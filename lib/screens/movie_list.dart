import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dart_movie_lookup/models/movie_option.dart';
import 'package:http/http.dart' as http;
import 'package:localization/localization.dart';
import '../widgets/options_drawer.dart';
import '../widgets/results.dart';

class MovieList extends StatefulWidget {
  const MovieList({
    super.key,
    required this.pageTitle,
    required this.url,
    required this.icon,
  });

  final String pageTitle;
  final Uri url;
  final Icon icon;

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  List<MovieOption> searchResults = [];
  bool _error = false;

  void _search() async {
    try {
      final response = await http.get(widget.url);
      final decoded = json.decode(response.body);

      if (response.statusCode >= 400) {
        setState(() {
          _error = true;
        });
      }

      setState(() {
        for (final movie in decoded['results']) {
          searchResults.add(
            MovieOption(
                id: movie['id'],
                title: movie['title'],
                releaseDate: movie['release_date'] ?? '',
                posterPath: movie['poster_path'] ?? ''),
          );
        }
      });
    } catch (err) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _search();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.movie_creation),
            const SizedBox(
              width: 10,
            ),
            Text(
              'movie-lookup'.i18n(),
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      drawer: const OptionsDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: _error
            ? Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: widget.icon,
                        ),
                        Text(
                          widget.pageTitle,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'error'.i18n(),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              )
            : Results(
                icon: widget.icon,
                pageTitle: widget.pageTitle,
                searchResults: searchResults,
              ),
      ),
    );
  }
}
