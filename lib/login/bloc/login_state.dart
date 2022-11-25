part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = FormzStatus.pure,
    this.username = const UsernameModel.pure(),
    this.password = const PasswordModel.pure(),
  });

  final FormzStatus status;
  final UsernameModel username;
  final PasswordModel password;

  LoginState copyWith({
    FormzStatus? status,
    UsernameModel? username,
    PasswordModel? password,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [status, username, password];
}
