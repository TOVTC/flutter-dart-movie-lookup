import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dart_movie_lookup/models/movie.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../widgets/options_drawer.dart';

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
  var content = 'nothing';

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
          originalTitle: decoded['original_title'],
          posterPath: decoded['poster_path'],
          language: decoded['original_language'],
          releaseDate: decoded['release_date'],
          runtime: decoded['runtime'],
          tagline: decoded['tagline'],
          homepage: decoded['homepage'],
          overview: decoded['overview'],
          genres: ['genre'],
          languages: ['language'],
          productionCompanies: ['company']);
    });
  }

  @override
  void initState() {
    super.initState();
    _getDetails();
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
          children: [
            Text(movie != null ? movie!.title.toString() : 'loading...'),
          ],
        ),
      ),
    );
  }
}
