import 'package:flutter/material.dart';
import 'package:flutter_dart_movie_lookup/screens/movie_list.dart';
import 'package:flutter_dart_movie_lookup/widgets/options_drawer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _formKey = GlobalKey<FormState>();
  var _searchTerm = '';

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 25),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      maxLength: 50,
                      decoration: const InputDecoration(
                        label: Text('Search for a film'),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().length > 50) {
                          return 'Please enter a search term between 1 and 50 characters';
                        }
                        return null;
                      },
                      onSaved: ((value) {
                        _searchTerm = value!;
                      }),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          Navigator.of(context).pop();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => MovieList(
                                pageTitle: 'Search Results:',
                                url: Uri.https(
                                  'api.themoviedb.org',
                                  '/3/search/movie',
                                  {
                                    'api_key': dotenv.env['API_KEY'],
                                    'language': 'en-US',
                                    'query': _searchTerm,
                                    'page': '1',
                                    'include_adult': 'false'
                                  },
                                ),
                              ),
                            ),
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      child: Text(
                        'Search',
                        style: TextStyle(color: Theme.of(context).colorScheme.surface),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
