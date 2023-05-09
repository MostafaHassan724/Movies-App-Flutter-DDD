import 'package:equatable/equatable.dart';

import 'genre.dart';

class Movie extends Equatable {
  const Movie({
    required this.id,
    required this.title,
    this.overview,
    this.budget,
    this.homepage,
    this.status,
    this.genres,
    this.language,
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
    this.adult = false,
    this.video = false,
  });

  final int id;
  final String title;
  final String? overview;
  final int? budget;
  final String? homepage;
  final String? status;
  final List<Genre>? genres;
  final String? language; //@JsonKey(name: "original_language")
  final String? posterPath; //@JsonKey(name: "poster_path")
  final String? backdropPath; //@JsonKey(name: "backdrop_path")
  final String? releaseDate; //@JsonKey(name: "release_date")
  final bool? adult;
  final bool? video;

  @override
  List<Object?> get props => [
        id,
        title,
        overview,
        budget,
        homepage,
        status,
        genres,
        language,
        posterPath,
        backdropPath,
        releaseDate,
        adult,
        video
      ];

  @override
  bool? get stringify => true;

  Movie copyWith({
    int? id,
    String? title,
    String? overview,
    int? budget,
    String? homepage,
    String? status,
    List<Genre>? genres,
    String? language,
    String? posterPath,
    String? backdropPath,
    String? releaseDate,
    bool? adult,
    bool? video,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      overview: overview ?? this.overview,
      budget: budget ?? this.budget,
      homepage: homepage ?? this.homepage,
      status: status ?? this.status,
      genres: genres ?? this.genres,
      language: language ?? this.language,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      releaseDate: releaseDate ?? this.releaseDate,
      adult: adult ?? this.adult,
      video: video ?? this.video,
    );
  }

  factory Movie.fromJson(Map<String, dynamic> json) {
    final list = json['genres'] as List;
    final genres = list.map((e) => Genre.fromJson(e)).toList();
    return Movie(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      budget: json['budget'],
      homepage: json['homepage'],
      status: json['status'],
      genres: genres,
      language: json['original_language'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      releaseDate: json['release_date'],
      adult: json['adult'],
      video: json['video'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'budget': budget,
      'homepage': homepage,
      'status': status,
      'genres': genres?.map((e) => e.toJson()).toList(),
      'original_language': language,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'release_date': releaseDate,
      'adult': adult,
      'video': video,
    };
  }
}
