class MovieModel {
  final bool isAdult;
  final int movieID;
  final String language;
  final String title;
  final String overview;
  final String posterImage;
  final String releaseDate;
  final int vote;

  MovieModel({
    required this.isAdult,
    required this.movieID,
    required this.language,
    required this.title,
    required this.overview,
    required this.posterImage,
    required this.releaseDate,
    required this.vote,
  });

  factory MovieModel.fromJson(json) {
    return MovieModel(
      isAdult: json['adult'],
      movieID: json['id'],
      language: json['original_language'],
      title: json['original_title'],
      overview: json['overview'],
      posterImage: json['poster_path'],
      releaseDate: json['release_date'],
      vote: json['vote_count'],
    );
  }
}
