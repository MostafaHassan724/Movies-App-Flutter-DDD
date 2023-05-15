import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:movies/domain/auth/value_objects.dart';
import 'package:movies/domain/core/failures.dart';

void main() {
  test(
    "any value object outputs Right(Type) should return the value if we try to retrieve it",
    () {
      final emailAddressFailed = EmailAddress('username@domain.com');
      expect(
        emailAddressFailed.value,
        equals(const Right('username@domain.com')),
      );
      expect(
        emailAddressFailed.getValueSafely(),
        equals('username@domain.com'),
      );
    },
  );
  test(
    "any value object outputs Left(Failure) should throw [Error] if we try to retrieve its value",
    () {
      final emailAddressFailed = EmailAddress('username@domain');
      expect(
        emailAddressFailed.value,
        equals(Left(InvalidEmailFailure())),
      );
      expect(
        () => emailAddressFailed.getValueSafely(),
        throwsA(isA<UnimplementedError>().having(
            (e) => e.message, 'error message', 'check value validation')),
      );
    },
  );
}
