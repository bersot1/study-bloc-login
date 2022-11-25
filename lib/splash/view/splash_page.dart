import 'package:flutter/material.dart';
import 'package:flutter_bloc_login/login/view/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static String route() => '/';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  navigateNextPage() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, LoginPage.route());
  }

  @override
  void initState() {
    super.initState();
    navigateNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
