// MainPage checks if user has already been logged in upon starting the app

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Buyer Side/Order pages/restaurant selection/restaurant_directory_page.dart';
import 'auth_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const RestaurantDirectoryPage();
            } else {
              return const AuthPage();
            }
          }),
    );
  }
}
