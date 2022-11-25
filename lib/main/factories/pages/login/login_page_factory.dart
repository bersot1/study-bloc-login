import 'package:flutter/material.dart';
import 'package:flutter_bloc_login/login/view/login_page.dart';

import 'login_bloc_factory.dart';

Widget makeLoginPageFactory() => LoginPage(loginBloc: makeLoginBlocFactory());
