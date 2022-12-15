import 'package:flutter_bloc_login/home/bloc/home_bloc.dart';

import '../../repositories/authentication_repository_factory.dart';
import '../../repositories/image_recognition_repository_factory.dart';

HomeBloc makeHomeBlocFactory() => HomeBloc(
      imageRecognitionRepository: makeImageRecognitionRespositoryFactory(),
      authenticationRepository: makeAuthenticationRepositoryFactory(),
    );
