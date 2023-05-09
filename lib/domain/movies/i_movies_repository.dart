import 'package:fpdart/fpdart.dart';
import '../core/failures.dart';
import 'package:dio/dio.dart' show CancelToken;

import 'movie.dart';

abstract class IMoviesRepository {
  Future<Either<Failure, List<Movie>>> getPopularMovies(
      {required int page, String language = "en-US", CancelToken? cancelToken});
  Future<Either<Failure, Movie>> fetchMovieByID(
      {required int movieID, CancelToken? cancelToken});
  Future<Either<Failure, List<Movie>>> searchMovies(
      {required int page, String query = "", CancelToken? cancelToken});
}
