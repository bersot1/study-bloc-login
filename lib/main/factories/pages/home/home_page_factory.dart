import 'package:flutter/material.dart';
import 'package:flutter_bloc_login/home/view/home_page.dart';

import 'home_bloc_factory.dart';

Widget makeHomePageFactory() => HomePage(homeBloc: makeHomeBlocFactory());
