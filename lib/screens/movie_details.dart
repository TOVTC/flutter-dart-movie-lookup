import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dart_movie_lookup/models/movie.dart';
import 'package:flutter_dart_movie_lookup/models/movie_option.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class MovieDetails extends StatefulWidget {
  const MovieDetails({
    super.key,
    required this.movieId,
    required this.film,
  });

  final int movieId;
  final String film;

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  Movie? movie;

  List<Widget> recommended = [];
  List<Widget> similar = [];

  bool _error = false;
  bool _recError = false;
  bool _simError = false;

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

    try {
      final response = await http.get(url);
      final decoded = json.decode(response.body);

      if (response.statusCode >= 400) {
        setState(() {
          _error = true;
        });
      }

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
    } catch (err) {
      setState(() {
        _error = true;
      });
    }
  }

  void _getRecommended() async {
    List<MovieOption> recommendedResults = [];
    List<Widget> convertRecommended = [];

    final url = Uri.https(
      'api.themoviedb.org',
      '/3/movie/${widget.movieId}/recommendations',
      {
        'api_key': dotenv.env['API_KEY'],
        'language': 'en-US',
        'page': '1',
      },
    );

    try {
      final response = await http.get(url);
      final decoded = json.decode(response.body);

      if (response.statusCode >= 400) {
        setState(() {
          _recError = true;
        });
      }

      for (final movie in decoded['results']) {
        recommendedResults.add(
          MovieOption(
            id: movie['id'],
            title: movie['title'],
            releaseDate: movie['release_date'] ?? '',
          ),
        );
      }

      for (final link in recommendedResults) {
        convertRecommended.add(
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => MovieDetails(
                    movieId: link.id,
                    film: link.title,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  link.releaseDate != ''
                      ? '${link.title} (${link.releaseDate.split('-')[0]})'
                      : link.title,
                  key: ValueKey(link.id),
                ),
              ),
            ),
          ),
        );
      }

      setState(() {
        recommended = convertRecommended;
      });
    } catch (err) {
      setState(() {
        _recError = true;
      });
    }
  }

  void _getSimilar() async {
    List<MovieOption> similarResults = [];
    List<Widget> convertSimilar = [];

    final url = Uri.https(
      'api.themoviedb.org',
      '/3/movie/${widget.movieId}/similar',
      {
        'api_key': dotenv.env['API_KEY'],
        'language': 'en-US',
        'page': '1',
      },
    );

    try {
      final response = await http.get(url);
      final decoded = json.decode(response.body);

      if (response.statusCode >= 400) {
        setState(() {
          _simError = true;
        });
      }

      for (final movie in decoded['results']) {
        similarResults.add(
          MovieOption(
            id: movie['id'],
            title: movie['title'],
            releaseDate: movie['release_date'] ?? '',
          ),
        );
      }

      for (final link in similarResults) {
        convertSimilar.add(
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => MovieDetails(
                    movieId: link.id,
                    film: link.title,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  link.releaseDate != ''
                      ? '${link.title} (${link.releaseDate.split('-')[0]})'
                      : link.title,
                  key: ValueKey(link.id),
                ),
              ),
            ),
          ),
        );
      }

      setState(() {
        similar = convertSimilar;
      });
    } catch (err) {
      setState(() {
        _simError = true;
      });
    }
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
    Widget verticalContent = const Text('Loading...');
    Widget horizontalContent = const Text('Loading...');

    if (movie != null) {
      List<Widget> evalRec() {
        if (_recError) {
          return const [Text('Something went wrong')];
        } else if (recommended.isNotEmpty) {
          return recommended;
        } else {
          return const [Text('Nothing to display')];
        }
      }

      List<Widget> evalSim() {
        if (_simError) {
          return const [Text('Something went wrong')];
        } else if (similar.isNotEmpty) {
          return similar;
        } else {
          return const [Text('Nothing to display')];
        }
      }

      List<Widget> rowOne = [
        Expanded(
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
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ];
      List<Widget> rowTwo = [
        Expanded(
          child: Column(
            children: [
              const Text(
                'Recommended Films:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Column(
                children: evalRec(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              const Text(
                'Similar Films:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Column(
                children: evalSim(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ];

      List<Widget> combineColumns() {
        List<Widget> vertical = [];
        vertical.addAll(rowOne);
        vertical.addAll(rowTwo);
        return vertical;
      }

      verticalContent = Column(
        children: [
          Text(
            movie!.originalTitle != '' ? movie!.originalTitle : movie!.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child:ListView(
                  children: combineColumns(),
              ),
            ),
          ),
        ],
      );

      horizontalContent = Column(
        children: [
          Text(
            movie!.originalTitle != '' ? movie!.originalTitle : movie!.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: rowOne,
                    ),
                    Row(
                      children: rowTwo,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    return LayoutBuilder(
      builder: (ctx, constraints) {
        final width = constraints.maxWidth;

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
            child: _error
                ? Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          widget.film,
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
                : (width >= 600 ? horizontalContent : verticalContent),
          ),
        );
      },
    );
  }
}
