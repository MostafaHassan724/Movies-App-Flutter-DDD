//Injection providers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movies/application/movies/movies_controller.dart';
import 'package:movies/application/settings/theme_provider.dart';
import 'package:movies/domain/auth/i_auth_repository.dart';
import 'package:movies/domain/movies/i_movies_repository.dart';
import 'package:movies/infrastructure/auth/firebase_auth_repository.dart';
import 'package:movies/infrastructure/movies/tmdb_movie_repository.dart';

import '../auth/auth_controller.dart';

// Injections providers

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final internetConnectionCheckerProvider =
    Provider<InternetConnectionChecker>((ref) {
  return InternetConnectionChecker();
});

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final googleSignInProvider = Provider<GoogleSignIn>((ref) {
  return GoogleSignIn();
});

final tmdbMovieRepositoryProvider = Provider<IMoviesRepository>((ref) {
  return TMDBMoviesRepository(
    ref.watch(dioProvider),
    dotenv.get('TMDB_KEY'),
    ref.watch(internetConnectionCheckerProvider),
  );
});

final firebaseAuthRepositoryProvider = Provider<IAuthRepository>((ref) {
  return FirebaseAuthRepository(
    ref.watch(firebaseAuthProvider),
    ref.watch(firebaseFirestoreProvider),
    ref.watch(googleSignInProvider),
    ref.watch(internetConnectionCheckerProvider),
  );
});

// Controllers providers

final authControllerNotifierProvider =
    AutoDisposeAsyncNotifierProvider<AuthControllerNotifier, void>(
        AuthControllerNotifier.new);

final moviesControllerNotifierProvider =
    AutoDisposeAsyncNotifierProvider<MoviesControllerNotifier, void>(
        MoviesControllerNotifier.new);

// Settings providers

final themeNotifierProvider =
    AutoDisposeNotifierProvider<ThemeNotifier, ThemeData>(ThemeNotifier.new);
