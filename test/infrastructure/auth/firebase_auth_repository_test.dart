import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies/infrastructure/auth/firebase_auth_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

void main() {
  MockFirebaseAuth mockFirebaseAuth;
  MockFirebaseFirestore mockFirebaseFirestore;
  MockGoogleSignIn mockGoogleSignIn;
  FirebaseAuthRepository firebaseAuthRepository;

  setUp(
    () {
      mockFirebaseAuth = MockFirebaseAuth();
      mockFirebaseFirestore = MockFirebaseFirestore();
      mockGoogleSignIn = MockGoogleSignIn();
      firebaseAuthRepository = FirebaseAuthRepository(
          mockFirebaseAuth, mockFirebaseFirestore, mockGoogleSignIn);
    },
  );
  group(
    "signUp() function",
    () {
      test(
        "sign up with email address and password should work fine with correct data",
        () async {},
      );
    },
  );
}
