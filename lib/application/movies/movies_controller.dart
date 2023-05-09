import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/providers.dart';

class MoviesControllerNotifier extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> gettingPopularMovies(
    int page,
  ) async {
    final moviesRepository = ref.read(tmdbMovieRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => moviesRepository.getPopularMovies(
        page: page,
      ),
    );
  }

  Future<void> searchingMovies(
    int page,
  ) async {
    final moviesRepository = ref.read(tmdbMovieRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => moviesRepository.searchMovies(
        page: page,
      ),
    );
  }

  Future<void> fetchingMovieByID(
    int movieID,
  ) async {
    final moviesRepository = ref.read(tmdbMovieRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => moviesRepository.fetchMovieByID(
        movieID: movieID,
      ),
    );
  }
}
