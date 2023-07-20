import 'package:flutter/material.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({
    super.key,
    required this.url,
  });

  final Uri url;

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details')),
      body: Text(widget.url.toString()),
    );
  }
}
