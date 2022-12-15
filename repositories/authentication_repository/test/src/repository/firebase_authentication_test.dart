import 'package:authentication_repository/authentication_repository.dart';
import 'package:faker/faker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart' as fbMocks;
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

void main() {
  late Authentication sut;

  late FirebaseAuth mockAuthService;
  late UserCredential mockUserCredential;
  late GoogleSignIn mockGoogleSignIn;
  late User mockUser;

  late UserEntity user;

  setUp(() {
    user = UserEntity(
      id: faker.guid.guid(),
      fullName: faker.person.name(),
      email: faker.internet.email(),
      isAnonymous: false,
      emailVerified: true,
      imageUrl: faker.internet.httpUrl(),
      phoneNumber: faker.phoneNumber.us(),
    );

    mockUser = MockUser();
    mockUserCredential = MockUserCredential();
    when(() => mockUserCredential.user).thenReturn(mockUser);
    mockAuthService = MockFirebaseAuth();
    mockGoogleSignIn = MockGoogleSignIn();

    sut = FirebaseAuthenticationRepository(authService: mockAuthService);
  });

  group("FBAuthentication - createUserWithEmailAndPassword", () {
    test('Should call methods with correct values', () async {
      final _email = faker.internet.email();
      final _pass = faker.lorem.word();

      final user = fbMocks.MockUser(
        isAnonymous: false,
        uid: 'someuid',
        email: _email,
        displayName: 'Bob',
      );

      final auth = fbMocks.MockFirebaseAuth(mockUser: user);

      final authentication = FirebaseAuthenticationRepository(authService: auth);

      final result = await authentication.createUserWithEmailAndPassword(email: _email, password: _pass);
      expect(result.email, _email);
    });

    <String, AuthError>{
      'invalid-email': AuthError.invalidEmail,
      'user-disabled': AuthError.userDisabled,
      'user-not-found': AuthError.userNotFound,
      'wrong-password': AuthError.wrongPassword,
      'email-already-in-use': AuthError.emailAlreadyInUse,
      'account-exists-with-different-credential': AuthError.emailAlreadyInUse,
      'invalid-credential': AuthError.invalidCredential,
      'operation-not-allowed': AuthError.operationNotAllowed,
      'weak-password': AuthError.weakPassword,
      'ERROR_MISSING_GOOGLE_AUTH_TOKEN': AuthError.error,
      'default': AuthError.error,
    }.forEach((codeError, matcher) async {
      test('Should return $matcher when throws exceptionCode $codeError', () async {
        when(
          () => mockAuthService.createUserWithEmailAndPassword(
              email: any(named: 'email'), password: any(named: 'password')),
        ).thenThrow(
          FirebaseAuthException(code: codeError),
        );

        try {
          await sut.createUserWithEmailAndPassword(email: 'email', password: 'password');
        } catch (e) {
          expect(e, isA<AuthError>());
          expect(e, matcher);
        }
      });
    });
  });

  group('FBAuthentication - signInWithEmailAndPassword', () {
    test('Should call methods with correct values', () async {
      final _email = faker.internet.email();
      final _pass = faker.lorem.word();

      final user = fbMocks.MockUser(
        isAnonymous: false,
        uid: 'someuid',
        email: _email,
        displayName: 'Bob',
      );

      final auth = fbMocks.MockFirebaseAuth(mockUser: user);

      final authentication = FirebaseAuthenticationRepository(authService: auth);

      final result = await authentication.signInWithEmailAndPassword(email: _email, password: _pass);
      expect(result.email, _email);
    });

    <String, AuthError>{
      'invalid-email': AuthError.invalidEmail,
      'user-disabled': AuthError.userDisabled,
      'user-not-found': AuthError.userNotFound,
      'wrong-password': AuthError.wrongPassword,
      'email-already-in-use': AuthError.emailAlreadyInUse,
      'account-exists-with-different-credential': AuthError.emailAlreadyInUse,
      'invalid-credential': AuthError.invalidCredential,
      'operation-not-allowed': AuthError.operationNotAllowed,
      'weak-password': AuthError.weakPassword,
      'ERROR_MISSING_GOOGLE_AUTH_TOKEN': AuthError.error,
      'default': AuthError.error,
    }.forEach((codeError, matcher) async {
      test('Should return $matcher when throws exceptionCode $codeError', () async {
        when(
          () =>
              mockAuthService.signInWithEmailAndPassword(email: any(named: 'email'), password: any(named: 'password')),
        ).thenThrow(
          FirebaseAuthException(code: codeError),
        );

        try {
          await sut.signInWithEmailAndPassword(email: 'email', password: 'password');
        } catch (e) {
          expect(e, isA<AuthError>());
          expect(e, matcher);
        }
      });
    });
  });

  group('FBAuthentication - signOut', () {
    test('Should call methods with correct values', () async {
      final _email = faker.internet.email();
      final _pass = faker.lorem.word();

      final user = fbMocks.MockUser(
        isAnonymous: false,
        uid: 'someuid',
        email: _email,
        displayName: 'Bob',
      );

      final auth = fbMocks.MockFirebaseAuth(mockUser: user);

      final authentication = FirebaseAuthenticationRepository(authService: auth);

      await authentication.signOut();

      expect(auth.currentUser, null);
    });

    <String, AuthError>{
      'invalid-email': AuthError.invalidEmail,
      'user-disabled': AuthError.userDisabled,
      'user-not-found': AuthError.userNotFound,
      'wrong-password': AuthError.wrongPassword,
      'email-already-in-use': AuthError.emailAlreadyInUse,
      'account-exists-with-different-credential': AuthError.emailAlreadyInUse,
      'invalid-credential': AuthError.invalidCredential,
      'operation-not-allowed': AuthError.operationNotAllowed,
      'weak-password': AuthError.weakPassword,
      'ERROR_MISSING_GOOGLE_AUTH_TOKEN': AuthError.error,
      'default': AuthError.error,
    }.forEach((codeError, matcher) async {
      test('Should return $matcher when throws exceptionCode $codeError', () async {
        when(
          () => mockAuthService.signOut(),
        ).thenThrow(
          FirebaseAuthException(code: codeError),
        );

        try {
          await sut.signOut();
        } catch (e) {
          expect(e, isA<AuthError>());
          expect(e, matcher);
        }
      });
    });
  });
}
