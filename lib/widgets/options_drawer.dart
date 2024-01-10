import 'package:flutter/material.dart';
import 'package:flutter_dart_movie_lookup/screens/homepage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localization/localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dart_movie_lookup/providers/locale_provider.dart';
import '../screens/movie_list.dart';

class OptionsDrawer extends ConsumerWidget {
  const OptionsDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String locale = ref.watch(localeProvider).toString().split('_').join('-');

    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DrawerHeader(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'powered-by'.i18n(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/tmdb.svg',
                      width: 200,
                      semanticsLabel: 'TMDB Logo',
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.search),
                title: Text(
                  'search'.i18n(),
                  style: const TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const Homepage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.trending_up),
                title: Text(
                  'trending'.i18n(),
                  style: const TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => MovieList(
                        icon: const Icon(Icons.trending_up),
                        pageTitle: '${'trending'.i18n()}:',
                        url: Uri.https(
                          'api.themoviedb.org',
                          '/3/trending/movie/day',
                          {
                            'api_key': dotenv.env['API_KEY'],
                            'language': locale,
                            'page': '1',
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.thumb_up),
                title: Text(
                  'popular'.i18n(),
                  style: const TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => MovieList(
                        icon: const Icon(Icons.thumb_up),
                        pageTitle: '${'popular'.i18n()}:',
                        url: Uri.https(
                          'api.themoviedb.org',
                          '/3/movie/popular',
                          {
                            'api_key': dotenv.env['API_KEY'],
                            'language': locale,
                            'page': '1',
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.star),
                title: Text(
                  'top-rated'.i18n(),
                  style: const TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => MovieList(
                        icon: const Icon(Icons.star),
                        pageTitle: '${'top-rated'.i18n()}:',
                        url: Uri.https(
                          'api.themoviedb.org',
                          '/3/movie/top_rated',
                          {
                            'api_key': dotenv.env['API_KEY'],
                            'language': locale,
                            'page': '1',
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.play_arrow),
                title: Text(
                  'now-playing'.i18n(),
                  style: const TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => MovieList(
                        icon: const Icon(Icons.play_arrow),
                        pageTitle: '${'now-playing'.i18n()}:',
                        url: Uri.https(
                          'api.themoviedb.org',
                          '/3/movie/now_playing',
                          {
                            'api_key': dotenv.env['API_KEY'],
                            'language': locale,
                            'page': '1',
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
                onPressed: () {
                  ref.read(localeProvider.notifier).setLocale();
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const Homepage(),
                    ),
                  );
                },
                child: Text(
                  "change-language".i18n(),
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.surface),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
