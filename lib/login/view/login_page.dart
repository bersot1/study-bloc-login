import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_login/home/view/home_page.dart';
import 'package:flutter_bloc_login/login/bloc/login_bloc.dart';
import 'package:formz/formz.dart';

import 'login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
    required LoginBloc loginBloc,
  }) : _loginBloc = loginBloc;

  final LoginBloc _loginBloc;

  static String route() => '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) => _loginBloc,
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.status == FormzStatus.submissionSuccess) {
                Navigator.pushReplacementNamed(context, HomePage.route());
              }
            },
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}
