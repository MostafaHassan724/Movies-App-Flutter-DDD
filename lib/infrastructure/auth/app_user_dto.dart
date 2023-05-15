import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../domain/auth/app_user.dart';
import '../../domain/auth/value_objects.dart';

class AppUserDTO extends Equatable {
  const AppUserDTO({
    required this.id,
    required this.emailAddress,
    required this.password,
    required this.username,
    required this.gender,
    required this.dateOfBirth,
  });

  final String id;
  final String emailAddress;
  final String password;
  final String username;
  final String gender;
  final String dateOfBirth;

  @override
  List<Object?> get props =>
      [id, emailAddress, password, username, gender, dateOfBirth];

  @override
  bool? get stringify => true;

  AppUserDTO copyWith({
    String? id,
    String? emailAddress,
    String? password,
    String? username,
    String? gender,
    String? dateOfBirth,
  }) {
    return AppUserDTO(
      id: id ?? this.id,
      emailAddress: emailAddress ?? this.emailAddress,
      password: password ?? this.password,
      username: username ?? this.username,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
  }

  factory AppUserDTO.fromDomain({required AppUser user}) {
    final dateOfBirthFormatted =
        DateFormat('dd/MM/yyyy').format(user.dateOfBirth); //needs check
    return AppUserDTO(
      id: user.id.getValueSafely(),
      emailAddress: user.emailAddress.getValueSafely(),
      password: user.password.getValueSafely(),
      username: user.username.getValueSafely(),
      gender: user.gender.name,
      dateOfBirth: dateOfBirthFormatted,
    );
  }

  AppUser toDomain() {
    final genderChosen = Gender.values
        .firstWhere((predefinedGender) => predefinedGender.name == gender);
    final dateOfBirthParsed = DateFormat('dd/MM/yyyy').parse(dateOfBirth);
    return AppUser(
      id: UniqueID.fromAlreadyExistingID(id: id),
      emailAddress: EmailAddress(emailAddress),
      password: Password(password),
      username: Username(username),
      gender: genderChosen,
      dateOfBirth: dateOfBirthParsed,
    );
  }

  factory AppUserDTO.fromJson(Map<String, dynamic> json) {
    return AppUserDTO(
      id: json['id'],
      emailAddress: json['email_address'],
      password: json['password'],
      username: json['username'],
      gender: json['gender'],
      dateOfBirth: json['date_of_birth'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email_address': emailAddress,
      'password': password,
      'username': username,
      'gender': gender,
      'date_of_birth': dateOfBirth,
    };
  }
}
