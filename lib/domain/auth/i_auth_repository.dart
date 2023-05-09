import 'package:fpdart/fpdart.dart';

import '../core/failures.dart';
import 'value_objects.dart';

abstract class IAuthRepository {
  Future<Either<Failure, Unit>> signUpWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
    required Username username,
    required Gender gender,
    required DateTime dateOfBirth,
  });
  Future<Either<Failure, Unit>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });
  Future<Either<Failure, Unit>> signInWithGoogle();
  Future<void> signOut();
}
