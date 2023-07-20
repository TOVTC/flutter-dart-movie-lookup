import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dart_movie_lookup/models/movie_option.dart';
import 'package:http/http.dart' as http;

import '../widgets/options_drawer.dart';

class MovieList extends StatefulWidget {
  const MovieList({
    super.key,
    this.searchTerm,
    required this.pageTitle,
    required this.url,
  });

  final String? searchTerm;
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
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.pageTitle,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (ctx, index) => GestureDetector(
                  onTap: () {
                    print(searchResults[index].id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      '${searchResults[index].title} (${searchResults[index].releaseDate.split('-')[0]})',
                      key: ValueKey(index),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
