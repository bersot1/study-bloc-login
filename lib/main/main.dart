import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc_login/home/view/home_page.dart';
import 'package:flutter_bloc_login/login/view/login_page.dart';
import 'package:flutter_bloc_login/main/factories/pages/home/home_page_factory.dart';
import 'package:flutter_bloc_login/main/factories/pages/login/login_page_factory.dart';
import 'package:flutter_bloc_login/splash/splash.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MaterialApp(
      title: "Study Bloc",
      initialRoute: SplashPage.route(),
      routes: {
        SplashPage.route(): (context) => SplashPage(),
        LoginPage.route(): (context) => makeLoginPageFactory(),
        HomePage.route(): (context) => makeHomePageFactory(),
      },
    );
  }
}
