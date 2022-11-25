import 'dart:async';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 2));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> LogIn({
    required String username,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    _controller.add(AuthenticationStatus.authenticated);
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
