import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:movies/domain/auth/app_user.dart';
import 'package:movies/domain/auth/value_objects.dart';
import 'package:movies/infrastructure/auth/app_user_dto.dart';

void main() {
  const appUserDTO = AppUserDTO(
    id: 'abcdef123',
    emailAddress: 'username@domain.com',
    password: 'PaSs100',
    username: '_username1',
    gender: 'male',
    dateOfBirth: '15/01/2000',
  );
  final appUser = AppUser(
    id: UniqueID.fromAlreadyExistingID(id: 'abcdef123'),
    emailAddress: EmailAddress('username@domain.com'),
    password: Password('PaSs100'),
    username: Username('_username1'),
    gender: Gender.male,
    dateOfBirth: DateTime.parse('2000-01-15'),
  );
  test(
    "toDomain() should return AppUser if everything is ok",
    () {
      final appUserToDomain = appUserDTO.toDomain();
      expect(
        appUserToDomain,
        isNotNull,
      );
      expect(
        appUserToDomain,
        appUser,
      );
      expect(
        appUserToDomain.dateOfBirth.toString(),
        '2000-01-15 00:00:00.000',
      );
    },
  );

  test(
    "fromDomain should return AppUserDTO if everything is ok",
    () {
      final appUserDTOFromDomain = AppUserDTO.fromDomain(user: appUser);
      expect(
        appUserDTOFromDomain,
        isNotNull,
      );
      expect(
        appUserDTOFromDomain,
        appUserDTO,
      );
      expect(
        appUserDTOFromDomain.dateOfBirth,
        '15/01/2000',
      );
    },
  );

  test(
    "fromJson() should work fine",
    () {
      final jsonMap = json.decode(
        File('test/fixtures/user.json').readAsStringSync(),
      );
      final appUserDTOFromJson = AppUserDTO.fromJson(jsonMap);
      expect(
        appUserDTOFromJson,
        appUserDTO,
      );
    },
  );
  test(
    "toJson() should work fine",
    () {
      final expectedJsonMap = {
        "id": "abcdef123",
        "email_address": "username@domain.com",
        "password": "PaSs100",
        "username": "_username1",
        "gender": "male",
        "date_of_birth": "15/01/2000"
      };
      final appUserDTOToJson = appUserDTO.toJson();
      expect(
        appUserDTOToJson,
        expectedJsonMap,
      );
    },
  );
}
