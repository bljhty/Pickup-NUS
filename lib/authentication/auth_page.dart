// switches between the register page and the login page

import 'package:flutter/material.dart';
import 'package:orbital_nus/authentication/pages/register_page.dart';
import 'package:orbital_nus/authentication/pages/login_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  // show login page first
  bool showLoginPage = true;

  // reverses the boolean value of showLoginPage each time the function is called
  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(showRegisterPage: toggleScreens,);
    } else {
      return RegisterPage(showLoginPage: toggleScreens,);
    }
  }
}
