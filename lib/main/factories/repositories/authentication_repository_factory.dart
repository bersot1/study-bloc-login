import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

Authentication makeAuthenticationRepositoryFactory() =>
    FirebaseAuthenticationRepository(authService: FirebaseAuth.instance);
