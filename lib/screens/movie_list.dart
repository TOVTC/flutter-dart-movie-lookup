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

  void _search() async {
    final response = await http.get(widget.url);
    final decoded = json.decode(response.body);
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
        padding: const EdgeInsets.all(20),
        child: Results(
          pageTitle: widget.pageTitle,
          searchResults: searchResults,
        ),
      ),
    );
  }
}
