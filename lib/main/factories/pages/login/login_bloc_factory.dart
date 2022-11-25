import 'package:flutter_bloc_login/login/bloc/login_bloc.dart';

import '../../repositories/authentication_repository_factory.dart';

LoginBloc makeLoginBlocFactory() => LoginBloc(authenticationRepository: makeAuthenticationRepositoryFactory());
