import '../models/models.dart';

abstract class Authentication {
  Future<UserEntity> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserEntity> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<UserEntity?> signInWithGoogle();

  Future<UserEntity?> getCurrentUser();
}
