import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import '../core/failures.dart';
import '../core/value_object.dart';
import 'value_validators.dart';

enum Gender {
  male,
  female,
  other,
}

class UniqueID extends ValueObject<String> {
  UniqueID._(this.value);

  @override
  final Either<Failure, String> value;

  /// Creates new generated unique ID.
  factory UniqueID() {
    return UniqueID._(right(const Uuid().v1()));
  }

  /// Creates ID class from stored id in firestore.
  factory UniqueID.fromAlreadyExistingID({required String id}) {
    return UniqueID._(right(id));
  }
}

class EmailAddress extends ValueObject<String> {
  EmailAddress._(this.value);

  @override
  final Either<Failure, String> value;

  factory EmailAddress(String emailAddressStr) {
    return EmailAddress._(validateEmailAddress(emailAddressStr));
  }
}

class Password extends ValueObject<String> {
  Password._(this.value);

  @override
  final Either<Failure, String> value;

  factory Password(String passwordStr) {
    return Password._(validatePassword(passwordStr));
  }
}

class Username extends ValueObject<String> {
  Username._(this.value);

  @override
  final Either<Failure, String> value;

  factory Username(String usernameStr) {
    return Username._(validateUsername(usernameStr));
  }
}
