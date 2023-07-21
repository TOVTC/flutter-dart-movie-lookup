import 'package:flutter/material.dart';
import 'package:flutter_dart_movie_lookup/models/movie_option.dart';
import 'package:flutter_dart_movie_lookup/screens/movie_details.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Results extends StatefulWidget {
  const Results({
    super.key,
    required this.pageTitle,
    required this.searchResults,
  });

  final String pageTitle;
  final List<MovieOption> searchResults;

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
            itemCount: widget.searchResults.length,
            itemBuilder: (ctx, index) => GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => MovieDetails(
                      movieId: widget.searchResults[index].id,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  widget.searchResults[index].releaseDate != ''
                      ? '${widget.searchResults[index].title} (${widget.searchResults[index].releaseDate.split('-')[0]})'
                      : widget.searchResults[index].title,
                  key: ValueKey(index),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
