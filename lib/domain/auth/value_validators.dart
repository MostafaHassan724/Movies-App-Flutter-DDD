import 'package:fpdart/fpdart.dart';

import '../core/failures.dart';

/// Email example : email@gmail.com
Either<Failure, String> validateEmailAddress(String emailStr) {
  final bool emailValid =
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(emailStr);
  if (emailValid) {
    return right(emailStr);
  } else {
    return left(InvalidEmailFailure());
  }
}

/// Password must contain at least one upper, one lower case letters and one digit.
/// It must be at least 6 characters long.
Either<Failure, String> validatePassword(String passwordStr) {
  final bool passwordValid =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$')
          .hasMatch(passwordStr);
  if (passwordValid) {
    return right(passwordStr);
  } else {
    return left(WeakPasswordFailure());
  }
}

/// Username must begin with a letter or underscore.
/// It must be at least 8 characters long.
Either<Failure, String> validateUsername(String usernameStr) {
  final bool userNameValid =
      RegExp(r'^(?=[a-zA-Z_])(?!0-9).{7,}$').hasMatch(usernameStr);
  if (userNameValid) {
    return right(usernameStr);
  } else {
    return left(InvalidUsernameFailure());
  }
}
