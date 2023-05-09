import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movies/infrastructure/core/connection_checker.dart';

import '../../domain/auth/app_user.dart';
import '../../domain/auth/i_auth_repository.dart';
import '../../domain/auth/value_objects.dart';
import '../../domain/core/failures.dart';
import 'app_user_dto.dart';

class FirebaseAuthRepository implements IAuthRepository {
  FirebaseAuthRepository(
    this._firebaseAuth,
    this._firebaseFirestore,
    this._googleSignIn,
    this._internetConnectionChecker,
  );
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final GoogleSignIn _googleSignIn;
  final InternetConnectionChecker _internetConnectionChecker;

  @override
  Future<Either<Failure, Unit>> signUpWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
    required Username username,
    required Gender gender,
    required DateTime dateOfBirth,
  }) async {
    try {
      if (await _internetConnectionChecker.isNotConnected) {
        return left(NoConnectionFailure(message: 'No Internet connection'));
      }
      final emailStr = emailAddress.getValueSafely();
      final passwordStr = password.getValueSafely();
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: emailStr, password: passwordStr);
      final appUserDTO = AppUserDTO.fromDomain(
        user: AppUser(
          id: UniqueID.fromAlreadyExistingID(id: userCredential.user!.uid),
          emailAddress: emailAddress,
          password: password,
          username: username,
          gender: gender,
          dateOfBirth: dateOfBirth,
        ),
      );
      final users = _firebaseFirestore.collection('users');
      users.doc(appUserDTO.id).set(appUserDTO.toJson());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return left(EmailAlreadyInUseFailure(message: 'Email already in use'));
      } else {
        return left(ServerFailure(message: 'Server Error'));
      }
    }
    return right(unit);
  }

  @override
  Future<Either<Failure, Unit>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    try {
      if (await _internetConnectionChecker.isNotConnected) {
        return left(NoConnectionFailure(message: 'No Internet connection'));
      }
      final emailStr = emailAddress.getValueSafely();
      final passwordStr = password.getValueSafely();
      await _firebaseAuth.signInWithEmailAndPassword(
          email: emailStr, password: passwordStr);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        return left(InvalidEmailAndPasswordFailure(
            message: 'Invalid email and password combination'));
      } else {
        return left(ServerFailure(message: 'Server Error'));
      }
    }
    return right(unit);
  }

  @override
  Future<Either<Failure, Unit>> signInWithGoogle() async {
    try {
      if (await _internetConnectionChecker.isNotConnected) {
        return left(NoConnectionFailure(message: 'No Internet connection'));
      }
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return left(AbortedSignInByUserFailure(message: 'Sign in stopped'));
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        return left(EmailAlreadyInUseFailure(message: 'Email already in use'));
      } else {
        return left(ServerFailure(message: 'Server Error'));
      }
    }
    return right(unit);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }
}
