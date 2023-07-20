import 'package:flutter/material.dart';
import 'package:flutter_dart_movie_lookup/screens/homepage.dart';
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
                      searchTerm: 'avengers',
                      pageTitle: 'Search Results:',
                      getFilms: () {
                        print('hello');
                      },
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
                }),
            ListTile(
                leading: const Icon(Icons.star),
                title: const Text(
                  'Top Rated',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  print('Top Rated');
                }),
            ListTile(
                leading: const Icon(Icons.play_arrow),
                title: const Text(
                  'Now Playing',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  print('Now Playing');
                }),
          ],
        ),
      ),
    );
  }
}
