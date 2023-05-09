import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  String get message;
  @override
  List<Object?> get props => [message];
}

// Common failures

class ServerFailure extends Failure {
  ServerFailure({required this.message});
  @override
  final String message;
}

class NoConnectionFailure extends Failure {
  NoConnectionFailure({required this.message});
  @override
  final String message;
}

// Value objects validaiton failures

class InvalidEmailFailure extends Failure {
  InvalidEmailFailure({required this.message});
  @override
  final String message;
}

class WeakPasswordFailure extends Failure {
  WeakPasswordFailure({required this.message});
  @override
  final String message;
}

class InvalidUsernameFailure extends Failure {
  InvalidUsernameFailure({required this.message});
  @override
  final String message;
}

// Authentication failures

class InvalidEmailAndPasswordFailure extends Failure {
  InvalidEmailAndPasswordFailure({required this.message});
  @override
  final String message;
}

class EmailAlreadyInUseFailure extends Failure {
  EmailAlreadyInUseFailure({required this.message});
  @override
  final String message;
}

class AbortedSignInByUserFailure extends Failure {
  AbortedSignInByUserFailure({required this.message});
  @override
  final String message;
}

// Movies retrieval failures

class MovieIDNotFoundFailure extends Failure {
  MovieIDNotFoundFailure({required this.message});
  @override
  final String message;
}

class EmptySearchListFailure extends Failure {
  EmptySearchListFailure({required this.message});
  @override
  final String message;
}
