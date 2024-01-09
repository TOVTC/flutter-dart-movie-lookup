import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class LookupAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LookupAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
