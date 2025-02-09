class tv_show {
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final String firstAirDate;
  final String name;
  final double voteAverage;
  final int voteCount;

  tv_show(
      {required this.adult,
      required this.backdropPath,
      required this.genreIds,
      required this.id,
      required this.originCountry,
      required this.originalLanguage,
      required this.originalName,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.firstAirDate,
      required this.name,
      required this.voteAverage,
      required this.voteCount});

  factory tv_show.fromJson(Map<String, dynamic> json) {
    return tv_show(
        adult: json['adult'],
        backdropPath: json['backdrop_path'],
        genreIds: json['genre_ids'].cast<int>(),
        id: json['id'],
        originCountry: json['origin_country'].cast<String>(),
        originalLanguage: json['original_language'],
        originalName: json['original_name'],
        overview: json['overview'],
        popularity: json['popularity'],
        posterPath: json['poster_path'],
        firstAirDate: json['first_air_date'],
        name: json['name'],
        voteAverage: json['vote_average'],
        voteCount: json['vote_count']);
  }
}
