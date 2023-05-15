import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:movies/domain/auth/value_validators.dart';
import 'package:movies/domain/core/failures.dart';

void main() {
  test(
    "email address value validator test, ex: username@domain.com",
    () {
      expect(
        validateEmailAddress('username@domain.com'),
        equals(const Right('username@domain.com')),
      );
      expect(
        validateEmailAddress('USERNAME@DOMAIN.NET'),
        equals(const Right('USERNAME@DOMAIN.NET')),
      );
      expect(
        validateEmailAddress('usernamedomain.com'),
        equals(Left(InvalidEmailFailure())),
      );
      expect(
        validateEmailAddress('username@domain'),
        equals(Left(InvalidEmailFailure())),
      );
      expect(
        validateEmailAddress('username!@domain.net'),
        equals(Left(InvalidEmailFailure())),
      );
      expect(
        validateEmailAddress('username@domain.'),
        equals(Left(InvalidEmailFailure())),
      );
      expect(
        validateEmailAddress('username@domain!.com'),
        equals(Left(InvalidEmailFailure())),
      );
    },
  );

  test(
    "password value validator test, ex: PaSs10, rules: one lower + one upper + one digit + at least six characters",
    () {
      expect(
        validatePassword('PaSs10'),
        equals(const Right('PaSs10')),
      );
      expect(
        validatePassword('Pa/Ss1!0'),
        equals(const Right('Pa/Ss1!0')),
      );
      expect(
        validatePassword('PaSsAb'),
        equals(Left(WeakPasswordFailure())),
      );
      expect(
        validatePassword('pass10'),
        equals(Left(WeakPasswordFailure())),
      );
      expect(
        validatePassword('PASS10'),
        equals(Left(WeakPasswordFailure())),
      );
      expect(
        validatePassword('passab'),
        equals(Left(WeakPasswordFailure())),
      );
      expect(
        validatePassword('PaSs1'),
        equals(Left(WeakPasswordFailure())),
      );
    },
  );

  test(
    "username value validator test, ex: _Username#1, rules: only begin with letter or underscore + at least eight characters",
    () {
      expect(
        validateUsername('_Username#1'),
        equals(const Right('_Username#1')),
      );
      expect(
        validateUsername('username'),
        equals(const Right('username')),
      );
      expect(
        validateUsername('user%name'),
        equals(const Right('user%name')),
      );
      expect(
        validateUsername('1username'),
        equals(Left(InvalidUsernameFailure())),
      );
      expect(
        validateUsername('%username'),
        equals(Left(InvalidUsernameFailure())),
      );
      expect(
        validateUsername('user'),
        equals(Left(InvalidUsernameFailure())),
      );
    },
  );
}
