import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dart_movie_lookup/models/movie_option.dart';
import 'package:http/http.dart' as http;

import '../widgets/options_drawer.dart';
import '../widgets/results.dart';

class MovieList extends StatefulWidget {
  const MovieList({
    super.key,
    required this.pageTitle,
    required this.url,
  });

  final String pageTitle;
  final Uri url;

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
            ),
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
        title: const Row(
          children: [
            Icon(Icons.movie_creation),
            SizedBox(
              width: 10,
            ),
            Text(
              'Movie Lookup',
              style: TextStyle(
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
                    child: Text(
                      widget.pageTitle,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Something went wrong',
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              )
            : Results(
                pageTitle: widget.pageTitle,
                searchResults: searchResults,
              ),
      ),
    );
  }
}
