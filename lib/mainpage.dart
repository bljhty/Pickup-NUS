import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_nus/login_screen.dart';
import 'package:orbital_nus/userhomepage.dart';

// MainPage checks if user has already been logged in upon starting the app
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return UserHomePage();
            } else {
            return LoginPage();
          }
    }
    ),
    );
  }
}
