import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dart_movie_lookup/models/movie_option.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../widgets/options_drawer.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({
    super.key,
    this.searchTerm,
    required this.pageTitle,
    required this.getFilms,
  });

  final String? searchTerm;
  final String pageTitle;
  final void Function() getFilms;

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  List<MovieOption> searchResults = [];

  void _search() async {
    // search for a term
    final url = Uri.https('api.themoviedb.org', '/3/search/movie', {
      'api_key': dotenv.env['API_KEY'],
      'language': 'en-US',
      'query': widget.searchTerm,
      'page': '1',
      'include_adult': 'false'
    });

    final response = await http.get(url);
    final decoded = json.decode(response.body);
    for (final movie in decoded['results']) {
      searchResults.add(
        MovieOption(
          id: movie['id'],
          title: movie['title'],
          releaseDate: movie['release_date'],
        ),
      );
    }
    print(searchResults[0].title);
    widget.getFilms();
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
      drawer: OptionsDrawer(),
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
