import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class SearchResults extends StatefulWidget {
  const SearchResults({
    super.key,
    required this.searchTerm,
  });

  final String searchTerm;

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  void _test() async {
    final url = Uri.https('api.themoviedb.org', '/3/search/movie', {
      'api_key': dotenv.env['API_KEY'],
      'language': 'en-US',
      'query': widget.searchTerm,
      'page': '1',
      'include_adult': 'false'
    });
    print('getting');
    print(await http.get(url));
  }

  @override
  void initState() {
    super.initState();
    _test();
  }

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
                      widget.searchTerm,
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
