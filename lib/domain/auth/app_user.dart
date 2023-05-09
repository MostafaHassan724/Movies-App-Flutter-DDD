import 'package:equatable/equatable.dart';

import 'value_objects.dart';

class AppUser extends Equatable {
  const AppUser({
    required this.id,
    required this.emailAddress,
    required this.password,
    required this.username,
    required this.gender,
    required this.dateOfBirth,
  });

  final UniqueID id;
  final EmailAddress emailAddress;
  final Password password;
  final Username username;
  final Gender gender;
  final DateTime dateOfBirth;

  @override
  List<Object?> get props => [
        id,
        emailAddress,
        password,
        username,
        gender,
        dateOfBirth,
      ];

  @override
  bool? get stringify => true;

  AppUser copyWith({
    UniqueID? id,
    EmailAddress? emailAddress,
    Password? password,
    Username? username,
    Gender? gender,
    DateTime? dateOfBirth,
  }) {
    return AppUser(
      id: id ?? this.id,
      emailAddress: emailAddress ?? this.emailAddress,
      password: password ?? this.password,
      username: username ?? this.username,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
  }
}
