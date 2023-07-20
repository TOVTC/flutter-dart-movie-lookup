import 'package:flutter/material.dart';
import 'package:flutter_dart_movie_lookup/screens/homepage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../screens/movie_list.dart';

class OptionsDrawer extends StatelessWidget {
  const OptionsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text('Powered by...'),
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
              title: const Text(
                'Search',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                print('Search');
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
              title: const Text(
                'Trending',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                print('Trending');
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => MovieList(
                      pageTitle: 'Trending:',
                      url: Uri.https(
                        'api.themoviedb.org',
                        '/3/search/movie',
                        {
                          'api_key': dotenv.env['API_KEY'],
                          'language': 'en-US',
                          'query': 'avengers',
                          'page': '1',
                          'include_adult': 'false'
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.thumb_up),
              title: const Text(
                'Popular',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                print('Popular');
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => MovieList(
                      pageTitle: 'Popular:',
                      url: Uri.https(
                        'api.themoviedb.org',
                        '/3/search/movie',
                        {
                          'api_key': dotenv.env['API_KEY'],
                          'language': 'en-US',
                          'query': 'avengers',
                          'page': '1',
                          'include_adult': 'false'
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text(
                'Top Rated',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                print('Top Rated');
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => MovieList(
                      pageTitle: 'Top Rated:',
                      url: Uri.https(
                        'api.themoviedb.org',
                        '/3/search/movie',
                        {
                          'api_key': dotenv.env['API_KEY'],
                          'language': 'en-US',
                          'query': 'avengers',
                          'page': '1',
                          'include_adult': 'false'
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.play_arrow),
              title: const Text(
                'Now Playing',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                print('Now Playing');
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => MovieList(
                      pageTitle: 'Now Playing:',
                      url: Uri.https(
                        'api.themoviedb.org',
                        '/3/search/movie',
                        {
                          'api_key': dotenv.env['API_KEY'],
                          'language': 'en-US',
                          'query': 'avengers',
                          'page': '1',
                          'include_adult': 'false'
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
