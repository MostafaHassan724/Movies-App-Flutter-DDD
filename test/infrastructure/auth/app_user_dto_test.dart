import 'package:flutter_test/flutter_test.dart';
import 'package:movies/domain/auth/app_user.dart';
import 'package:movies/domain/auth/value_objects.dart';
import 'package:movies/infrastructure/auth/app_user_dto.dart';

void main() {
  test(
    "toDomain() should return AppUser if everything is ok",
    () {
      const appUserDTO = AppUserDTO(
        id: 'abcdef123',
        emailAddress: 'username@domain.com',
        password: 'PaSs100',
        username: '_username1',
        gender: 'male',
        dateOfBirth: '15/01/2000',
      );
      final appUser = appUserDTO.toDomain();
      expect(
        appUser,
        isNotNull,
      );
      expect(
        appUser.dateOfBirth.toString(),
        '2000-01-15 00:00:00.000',
      );
    },
  );

  test(
    "fromDomain should return AppUserDTO if everything is ok",
    () {
      final appUser = AppUser(
        id: UniqueID.fromAlreadyExistingID(id: 'abcdef123'),
        emailAddress: EmailAddress('username@domain.com'),
        password: Password('PaSs100'),
        username: Username('_username1'),
        gender: Gender.male,
        dateOfBirth: DateTime.parse('2000-01-15'),
      );
      final appUserDTO = AppUserDTO.fromDomain(user: appUser);
      expect(
        appUserDTO,
        isNotNull,
      );
      expect(
        appUserDTO.dateOfBirth,
        '15/01/2000',
      );
    },
  );
}
