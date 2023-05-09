import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movies/infrastructure/core/connection_checker.dart';

import '../../domain/core/failures.dart';
import '../../domain/movies/i_movies_repository.dart';
import '../../domain/movies/movie.dart';
import '../../domain/movies/tmdb_response.dart';

class TMDBMoviesRepository implements IMoviesRepository {
  TMDBMoviesRepository(
      this._client, this._apiKey, this._internetConnectionChecker);

  final Dio _client;
  final String _apiKey;
  final InternetConnectionChecker _internetConnectionChecker;

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies({
    required int page,
    String language = "en-US",
    CancelToken? cancelToken,
  }) async {
    try {
      if (await _internetConnectionChecker.isNotConnected) {
        return left(NoConnectionFailure(message: 'No internet connection'));
      }
      final url = Uri(
        scheme: "https",
        host: "api.themoviedb.org",
        path: "3/movie/popular",
        //query: query,
        queryParameters: {
          'api_key': _apiKey,
          'language': language,
          'page': page,
        },
      ).toString();
      final response = await _client.get(url, cancelToken: cancelToken);
      if (response.statusCode == 200) {
        final results = TMDBResponse.fromJson(response.data).results;
        if (results!.isEmpty) {
          return left(
              EmptySearchListFailure(message: 'No search results found'));
        } else {
          return right(results);
        }
      }
    } catch (_) {
      return left(ServerFailure(message: 'Server Error'));
    }
    return right(List.empty());
  }

  // https://api.themoviedb.org/3/search/movie?api_key=$api_key&page=$page

  @override
  Future<Either<Failure, List<Movie>>> searchMovies({
    required int page,
    String query = "",
    CancelToken? cancelToken,
  }) async {
    try {
      if (await _internetConnectionChecker.isNotConnected) {
        return left(NoConnectionFailure(message: 'No internet connection'));
      }
      final url = Uri(
        scheme: "https",
        host: "api.themoviedb.org",
        path: "3/search/movie",
        //query: query,
        queryParameters: {
          'api_key': _apiKey,
          'page': page,
          'query': query,
        },
      ).toString();
      final response = await _client.get(url, cancelToken: cancelToken);
      if (response.statusCode == 200) {
        final results = TMDBResponse.fromJson(response.data).results;
        if (results!.isEmpty) {
          return left(
              EmptySearchListFailure(message: 'No search results found'));
        } else {
          return right(results);
        }
      }
    } catch (_) {
      return left(ServerFailure(message: 'Server Error'));
    }
    return right(List.empty());
  }

  ///https://api.themoviedb.org/3/movie/$movieID?api_key=$api_key

  @override
  Future<Either<Failure, Movie>> fetchMovieByID(
      {required int movieID, CancelToken? cancelToken}) async {
    try {
      if (await _internetConnectionChecker.isNotConnected) {
        return left(NoConnectionFailure(message: 'No internet connection'));
      }
      final url = Uri(
        scheme: "https",
        host: "api.themoviedb.org",
        path: "3/movie/$movieID",
        queryParameters: {
          'api_key': _apiKey,
        },
      ).toString();
      final response = await _client.get(url, cancelToken: cancelToken);
      if (response.statusCode == 200) {
        final result = Movie.fromJson(response.data);
        return right(result);
      } else {
        return left(MovieIDNotFoundFailure(message: 'Movie is not found'));
      }
    } catch (_) {
      return left(ServerFailure(message: 'Server Error'));
    }
  }
}
