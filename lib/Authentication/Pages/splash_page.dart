/// Page for loading while users first boot up the app
/// contains logo of pickup@NUS

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:orbital_nus/authentication/main_page.dart';
import 'package:orbital_nus/colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    _navigateToHome();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();

    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: ((context) => const MainPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset('assets/images/Logo.png', width: 250),
            ),
          )
        ],
      ),
    );
  }
}
