class MovieOption {
  const MovieOption ({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.posterPath,
  });

  final int id;
  final String title;
  final String releaseDate;
  final String posterPath;
}