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

// "genres": [
// {
// "id": 12,
// "name": "Adventure"
// },
// {
// "id": 28,
// "name": "Action"
// },
// {
// "id": 878,
// "name": "Science Fiction"
// }
// ],
// "homepage": "https://www.marvel.com/movies/avengers-infinity-war",
// "id": 299536,
// "original_language": "en",
// "original_title": "Avengers: Infinity War",
// "overview": "As the Avengers and their allies have continued to protect the world from threats too large for any one hero to handle, a new danger has emerged from the cosmic shadows: Thanos. A despot of intergalactic infamy, his goal is to collect all six Infinity Stones, artifacts of unimaginable power, and use them to inflict his twisted will on all of reality. Everything the Avengers have fought for has led up to this moment - the fate of Earth and existence itself has never been more uncertain.",
// "poster_path": "/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg",
// "production_companies": [
// {
// "id": 420,
// "logo_path": "/hUzeosd33nzE5MCNsZxCGEKTXaQ.png",
// "name": "Marvel Studios",
// "origin_country": "US"
// }
// ],
// "release_date": "2018-04-25",
// "runtime": 149,
// "spoken_languages": [
// {
// "english_name": "English",
// "iso_639_1": "en",
// "name": "English"
// },
// {
// "english_name": "Xhosa",
// "iso_639_1": "xh",
// "name": ""
// }
// ],
// "tagline": "An entire universe. Once and for all.",
// "title": "Avengers: Infinity War",
// }