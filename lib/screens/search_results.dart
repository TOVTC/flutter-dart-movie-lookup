import 'package:flutter/material.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({
    super.key,
    required this.searchTerm,
  });

  final String searchTerm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Lookup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Search Results:'),
            Expanded(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (ctx, index) => Text(searchTerm, key: ValueKey(index)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
