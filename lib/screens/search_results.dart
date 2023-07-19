import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
        title: const Text(
          'Movie Lookup',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search Results:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (ctx, index) => GestureDetector(
                  onTap: () {
                    print(dotenv.env['API_KEY']);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      searchTerm,
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
