import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/models.dart';
import 'authentication.dart';

class FirebaseAuthenticationRepository implements Authentication {
  FirebaseAuthenticationRepository({
    required auth.FirebaseAuth authService,
  }) : _firebaseAuth = authService;

  final auth.FirebaseAuth _firebaseAuth;

  @override
  Future<UserEntity> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return _mapFirebaseUser(_firebaseAuth.currentUser!);
    } on auth.FirebaseAuthException catch (e) {
      throw _determineError(e);
    }
  }

  @override
  Future<UserEntity> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return _mapFirebaseUser(userCredential.user!);
    } on auth.FirebaseAuthException catch (e) {
      throw _determineError(e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on auth.FirebaseAuthException catch (e) {
      throw _determineError(e);
    }
  }

  @override
  Future<UserEntity?> signInWithGoogle() async {
    try {
      late UserEntity? _user;

      final GoogleSignIn googleSignIn = GoogleSignIn(scopes: <String>['email']);
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final googleSignInAuthentication = await googleSignInAccount.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final userCredential = await _firebaseAuth.signInWithCredential(credential);

        _user = UserEntity(
          id: userCredential.user!.uid,
          fullName: userCredential.user?.displayName,
          email: userCredential.user?.email,
          imageUrl: userCredential.user?.photoURL,
          emailVerified: userCredential.user?.emailVerified ?? false,
          isAnonymous: userCredential.user?.isAnonymous ?? true,
          phoneNumber: userCredential.user?.phoneNumber,
        );
      }

      return _user;
    } on auth.FirebaseAuthException catch (e) {
      throw _determineError(e);
    }
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    UserEntity? _user;
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      _user = UserEntity(
        id: currentUser.uid,
        fullName: currentUser.displayName,
        email: currentUser.email,
        imageUrl: currentUser.photoURL,
        emailVerified: currentUser.emailVerified,
        isAnonymous: currentUser.isAnonymous,
        phoneNumber: currentUser.phoneNumber,
      );
    }
    return _user;
  }

  UserEntity _mapFirebaseUser(auth.User? user) {
    if (user == null) {
      return UserEntity.empty();
    }

    return UserEntity(
      id: user.uid,
      fullName: user.displayName,
      email: user.email,
      emailVerified: user.emailVerified,
      imageUrl: user.photoURL,
      isAnonymous: user.isAnonymous,
      phoneNumber: user.phoneNumber,
    );
  }

  AuthError _determineError(auth.FirebaseAuthException exception) {
    switch (exception.code) {
      case 'invalid-email':
        return AuthError.invalidEmail;
      case 'user-disabled':
        return AuthError.userDisabled;
      case 'user-not-found':
        return AuthError.userNotFound;
      case 'wrong-password':
        return AuthError.wrongPassword;
      case 'email-already-in-use':
      case 'account-exists-with-different-credential':
        return AuthError.emailAlreadyInUse;
      case 'invalid-credential':
        return AuthError.invalidCredential;
      case 'operation-not-allowed':
        return AuthError.operationNotAllowed;
      case 'weak-password':
        return AuthError.weakPassword;
      case 'ERROR_MISSING_GOOGLE_AUTH_TOKEN':
      default:
        return AuthError.error;
    }
  }
}
