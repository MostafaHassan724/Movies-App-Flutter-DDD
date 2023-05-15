import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

// Common failures

class ServerFailure extends Failure {}

class NoConnectionFailure extends Failure {}

// Value objects validaiton failures

class InvalidEmailFailure extends Failure {}

class WeakPasswordFailure extends Failure {}

class InvalidUsernameFailure extends Failure {}

// Authentication failures

class InvalidEmailAndPasswordFailure extends Failure {}

class EmailAlreadyInUseFailure extends Failure {}

class AbortedSignInByUserFailure extends Failure {}

// Movies retrieval failures

class MovieIDNotFoundFailure extends Failure {}

class EmptySearchListFailure extends Failure {}
