import 'package:fpdart/fpdart.dart';

import '../core/failures.dart';

/// Email example : email@gmail.com
Either<Failure, String> validateEmailAddress(String emailStr) {
  final bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(emailStr);
  if (emailValid) {
    return right(emailStr);
  } else {
    return left(
        InvalidEmailFailure(message: 'Email example : email@gmail.com'));
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
    return left(WeakPasswordFailure(
        message: '''Password must contain at least one upper, 
    one lower case letters and one digit.
    It must be at least 6 characters long.'''));
  }
}

/// Username must have only alphanumeric characters and underscore.
/// It must be at least 8 characters long.
Either<Failure, String> validateUsername(String usernameStr) {
  final bool userNameValid =
      RegExp(r'^[a-zA-Z0-9_].{8,}$').hasMatch(usernameStr);
  if (userNameValid) {
    return right(usernameStr);
  } else {
    return left(InvalidUsernameFailure(
        message:
            '''Username must have only alphanumeric characters and underscore.
    It must be at least 8 characters long.'''));
  }
}
