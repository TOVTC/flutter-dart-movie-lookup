class Movie {
  const Movie({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.posterPath,
    required this.language,
    required this.releaseDate,
    required this.runtime,
    required this.tagline,
    required this.homepage,
    required this.overview,
    required this.genres,
    required this.languages,
    required this.productionCompanies
  });

  final int id; // id
  final String title; // title
  final String originalTitle; // original_title
  final String posterPath; // poster_path
  final String language; // original_language
  final String releaseDate; // release_date
  final int runtime; // runtime
  final String tagline; // tagline
  final String homepage; // homepage
  final String overview; // overview
  final List<String> genres; // genres, but extract the strings
  final List<String> languages; // spoken_languages, but extract the strings
  final List<String> productionCompanies; // production_companies, but extract the strings
}