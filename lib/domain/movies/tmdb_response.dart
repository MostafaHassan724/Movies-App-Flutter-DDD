import 'package:equatable/equatable.dart';

import 'movie.dart';

class TMDBResponse extends Equatable {
  const TMDBResponse({required this.pages, this.results});

  final int pages;
  final List<Movie>? results;

  @override
  List<Object?> get props => [pages, results];

  @override
  bool? get stringify => true;

  TMDBResponse copyWith({
    int? pages,
    List<Movie>? results,
  }) {
    return TMDBResponse(
      pages: pages ?? this.pages,
      results: results ?? this.results,
    );
  }

  factory TMDBResponse.fromJson(Map<String, dynamic> json) {
    final list = json['results'] as List;
    final results = list.map((e) => Movie.fromJson(e)).toList();
    return TMDBResponse(
      pages: json['pages'],
      results: results,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pages': pages,
      'results': results?.map((e) => e.toJson()).toList(),
    };
  }
}
