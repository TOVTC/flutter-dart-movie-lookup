import 'package:flutter/material.dart';
import 'package:flutter_dart_movie_lookup/screens/movie_list.dart';
import 'package:flutter_dart_movie_lookup/widgets/options_drawer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:localization/localization.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key, required this.setLocale});
  final VoidCallback setLocale;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _formKey = GlobalKey<FormState>();
  String _searchTerm = '';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.movie_creation),
            const SizedBox(
              width: 10,
            ),
            Text(
              'movie-lookup'.i18n(),
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      drawer: OptionsDrawer(setLocale: widget.setLocale),
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
                      decoration: InputDecoration(
                        label: Text('search-placeholder'.i18n()),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().length > 50) {
                          return 'search-validation'.i18n();
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
                                pageTitle: 'search-results-title'.i18n([_searchTerm]),
                                url: Uri.https(
                                  'api.themoviedb.org',
                                  '/3/search/movie',
                                  {
                                    'api_key': dotenv.env['API_KEY'],
                                    'language': Localizations.localeOf(context).toString(),
                                    'query': _searchTerm,
                                    'page': '1',
                                    'include_adult': 'false'
                                  },
                                ),
                                setLocale: widget.setLocale,
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
                        'search'.i18n(),
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
