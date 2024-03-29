import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dart_movie_lookup/models/movie_option.dart';
import 'package:flutter_dart_movie_lookup/screens/movie_details.dart';
import 'package:flutter_dart_movie_lookup/utils/truncate_string.dart';
import 'package:localization/localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dart_movie_lookup/providers/locale_provider.dart';

class Results extends ConsumerStatefulWidget {
  const Results({
    super.key,
    required this.pageTitle,
    required this.searchResults,
    required this.icon
  });

  final String pageTitle;
  final List<MovieOption> searchResults;
  final Icon icon;

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
                  locale:
                      ref.watch(localeProvider).toString().split('_').join('-'),
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: widget.searchResults[index].posterPath != ''
                      ? CachedNetworkImage(
                          imageUrl: 'https://image.tmdb.org/t/p/original${widget.searchResults[index].posterPath}',
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                          width: 20,
                        )
                      : Image.asset(
                          './assets/favicon.png',
                          width: 20,
                        ),
                ),
                Text(
                  widget.searchResults[index].releaseDate != ''
                      ? '${truncateString(MediaQuery.of(context).size.width * (0.5), widget.searchResults[index].title, null)} (${widget.searchResults[index].releaseDate.split('-')[0]})'
                      : truncateString(
                          MediaQuery.of(context).size.width * (0.5),
                          widget.searchResults[index].title,
                          null),
                  key: ValueKey(index),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: widget.icon,
            ),
            Expanded(
              child: Text(
                widget.pageTitle,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Expanded(
          child: content,
        ),
      ],
    );
  }
}
