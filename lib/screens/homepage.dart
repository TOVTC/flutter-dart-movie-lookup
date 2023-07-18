import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _formKey = GlobalKey<FormState>();
  final _searchTerm = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Lookup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const SizedBox(height: 25),
            Form(
              key: _formKey,
              child: TextFormField(
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text('Search for a film'),
                    ),
                  ),
            ),
          ],
        ),
      ),
        );
  }
}
