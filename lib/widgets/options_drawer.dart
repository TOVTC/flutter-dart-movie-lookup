import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            const SizedBox(height: 20),
            const Row(
              children: [
                Icon(Icons.trending_up),
                SizedBox(width: 10),
                Text(
                  'Trending',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Icon(Icons.thumb_up),
                SizedBox(width: 10),
                Text('Popular',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Icon(Icons.star),
                SizedBox(width: 10),
                Text('Top Rated',
                  style: TextStyle(fontSize: 20),),
              ],
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Icon(Icons.play_arrow),
                SizedBox(width: 10),
                Text('Now Playing',
                  style: TextStyle(fontSize: 20),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
