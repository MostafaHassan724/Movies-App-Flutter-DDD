import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/auth/value_objects.dart';
import '../core/providers.dart';

class AuthControllerNotifier extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> signUpWithEmailAndPassword({
    required String emailAddressStr,
    required String passwordStr,
    required String usernameStr,
    required String gender,
    required String dateOfBirth,
  }) async {
    final authRepository = ref.read(firebaseAuthRepositoryProvider);
    state = const AsyncLoading();
    state =
        await AsyncValue.guard(() => authRepository.signUpWithEmailAndPassword(
              emailAddress: EmailAddress(emailAddressStr),
              password: Password(passwordStr),
              username: Username(usernameStr),
              gender: Gender.values.firstWhere(
                  (predefinedGender) => predefinedGender.name == gender),
              dateOfBirth: DateTime.parse(dateOfBirth),
            ));
  }

  Future<void> signInWithEmailAndPassword({
    required String emailAddressStr,
    required String passwordStr,
  }) async {
    final authRepository = ref.read(firebaseAuthRepositoryProvider);
    state = const AsyncLoading();
    state =
        await AsyncValue.guard(() => authRepository.signInWithEmailAndPassword(
              emailAddress: EmailAddress(emailAddressStr),
              password: Password(passwordStr),
            ));
  }

  Future<void> signInWithGoogle() async {
    final authRepository = ref.read(firebaseAuthRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => authRepository.signInWithGoogle());
  }

  Future<void> singOut() async {
    final authRepository = ref.read(firebaseAuthRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => authRepository.signOut());
  }
}
