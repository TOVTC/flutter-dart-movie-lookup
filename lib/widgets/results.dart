import 'package:flutter/material.dart';
import 'package:flutter_dart_movie_lookup/models/movie_option.dart';
import 'package:flutter_dart_movie_lookup/screens/movie_details.dart';
import 'package:localization/localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dart_movie_lookup/providers/locale_provider.dart';

class Results extends ConsumerStatefulWidget {
  const Results({
    super.key,
    required this.pageTitle,
    required this.searchResults,
  });

  final String pageTitle;
  final List<MovieOption> searchResults;

  @override
  ConsumerState<Results> createState() => _ResultsState();
}

class _ResultsState extends ConsumerState<Results> {
  Widget content = Text('no-results'.i18n());

  @override
  Widget build(BuildContext context) {
    if (widget.searchResults.isNotEmpty) {
      content = ListView.builder(
        itemCount: widget.searchResults.length,
        itemBuilder: (ctx, index) => GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => MovieDetails(
                  movieId: widget.searchResults[index].id,
                  film: widget.searchResults[index].title,
                  locale: ref.watch(localeProvider).toString().split('_').join('-'),
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
      );
    }
    return content = Column(
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
          child: content,
        ),
      ],
    );
  }
}
