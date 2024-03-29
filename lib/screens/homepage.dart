import 'package:flutter/material.dart';
import 'package:flutter_dart_movie_lookup/screens/movie_list.dart';
import 'package:flutter_dart_movie_lookup/widgets/options_drawer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:localization/localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dart_movie_lookup/providers/locale_provider.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  final _formKey = GlobalKey<FormState>();
  var _searchTerm = '';

  @override
  Widget build(BuildContext context) {
    String locale = ref.watch(localeProvider).toString().split('_').join('-');

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
                                icon: const Icon(Icons.search),
                                pageTitle:
                                    'search-results-title'.i18n([_searchTerm]),
                                url: Uri.https(
                                  'api.themoviedb.org',
                                  '/3/search/movie',
                                  {
                                    'api_key': dotenv.env['API_KEY'],
                                    'language': locale,
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
                        'search'.i18n(),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.surface),
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
