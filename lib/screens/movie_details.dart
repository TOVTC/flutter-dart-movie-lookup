import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dart_movie_lookup/models/movie.dart';
import 'package:flutter_dart_movie_lookup/models/movie_option.dart';
import 'package:flutter_dart_movie_lookup/widgets/results.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class MovieDetails extends StatefulWidget {
  const MovieDetails({
    super.key,
    required this.movieId,
  });

  final int movieId;

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  Movie? movie;
  List<MovieOption> recommendedResults = [];
  List<MovieOption> similarResults = [];

  List<String> _parseObjects(String propName, List<dynamic> data) {
    List<String> targetValues = [];

    for (var entry in data) {
      targetValues.add(entry[propName]);
    }
    return targetValues;
  }

  String _computeRuntime(int runtime) {
    if (runtime == 0) {
      return '';
    }
    int hours = (runtime ~/ 60);
    int minutes = runtime % 60;
    return '${hours}h ${minutes}min';
  }

  void _getDetails() async {
    final url = Uri.https(
      'api.themoviedb.org',
      '3/movie/${widget.movieId}',
      {
        'api_key': dotenv.env['API_KEY'],
      },
    );

    final response = await http.get(url);
    final decoded = json.decode(response.body);

    setState(() {
      movie = Movie(
        id: decoded['id'],
        title: decoded['title'],
        originalTitle: decoded['original_title'] ?? '',
        posterPath: decoded['poster_path'] ?? '',
        language: decoded['original_language'] ?? '',
        releaseDate: decoded['release_date'] ?? '',
        runtime: decoded['runtime'] ?? 0,
        tagline: decoded['tagline'] ?? '',
        homepage: decoded['homepage'] ?? '',
        overview: decoded['overview'] ?? '',
        genres: _parseObjects('name', decoded['genres']),
        languages: _parseObjects('english_name', decoded['spoken_languages']),
        productionCompanies:
            _parseObjects('name', decoded['production_companies']),
      );
    });
  }

  void _getRecommended() async {
    final url = Uri.https(
      'api.themoviedb.org',
      '/3/movie/${widget.movieId}/recommendations',
      {
        'api_key': dotenv.env['API_KEY'],
        'language': 'en-US',
        'page': '1',
      },
    );

    final response = await http.get(url);
    final decoded = json.decode(response.body);
    setState(() {
      for (final movie in decoded['results']) {
        recommendedResults.add(
          MovieOption(
            id: movie['id'],
            title: movie['title'],
            releaseDate: movie['release_date'] ?? '',
          ),
        );
      }
    });
    print(recommendedResults);
  }

  void _getSimilar() async {
    final url = Uri.https(
      'api.themoviedb.org',
      '/3/movie/${widget.movieId}/recommendations',
      {
        'api_key': dotenv.env['API_KEY'],
        'language': 'en-US',
        'page': '1',
      },
    );

    final response = await http.get(url);
    final decoded = json.decode(response.body);
    setState(() {
      for (final movie in decoded['results']) {
        similarResults.add(
          MovieOption(
            id: movie['id'],
            title: movie['title'],
            releaseDate: movie['release_date'] ?? '',
          ),
        );
      }
    });
    print(similarResults);
  }

  @override
  void initState() {
    super.initState();
    _getDetails();
    _getRecommended();
    _getSimilar();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Text('Loading...');

    if (movie != null) {
      content = Column(
        children: [
          Text(
            movie!.originalTitle != '' ? movie!.originalTitle : movie!.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Semantics(
                      label: '${movie!.title} movie poster',
                      child: movie!.posterPath != ''
                          ? Image.network(
                              'https://image.tmdb.org/t/p/original${movie!.posterPath}',
                              width: 200,
                            )
                          : Image.asset(
                              './assets/favicon.png',
                              width: 200,
                            ),
                    ),
                    const SizedBox(height: 20),
                    Offstage(
                      offstage: movie!.tagline.isEmpty,
                      child: Column(
                        children: [
                          Text(
                            '"${movie!.tagline}"',
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    Offstage(
                      offstage: movie!.releaseDate.isEmpty,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Release Date - ${movie!.releaseDate}',
                            ),
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                    Offstage(
                      offstage: movie!.runtime == 0,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Runtime - ${_computeRuntime(movie!.runtime)}',
                            ),
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                    Offstage(
                      offstage: movie!.genres.isEmpty,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Genres - ${movie!.genres.join(', ')}',
                            ),
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                    Offstage(
                      offstage: movie!.language.isEmpty,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Languages (${movie!.language})${movie!.languages.isNotEmpty ? ' - ${movie!.languages.join(', ')}' : ''}',
                            ),
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                    Offstage(
                      offstage: movie!.productionCompanies.isEmpty,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Production Company - ${movie!.productionCompanies.join(', ')}',
                            ),
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                    Offstage(
                      offstage: movie!.homepage.isEmpty,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              movie!.homepage,
                              style: const TextStyle(color: Colors.blue),
                            ),
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                    Offstage(
                      offstage: movie!.overview.isEmpty,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Synopsis: ${movie!.overview}',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Results(
              pageTitle: 'Recommended Films:',
              searchResults: recommendedResults,
            ),
          ),
          Expanded(
            child: Results(
              pageTitle: 'Similar Films:',
              searchResults: similarResults,
            ),
          ),
        ],
      );
    }

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
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: content,
      ),
    );
  }
}
