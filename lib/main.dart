/// Initial startup file for running pickup@NUS
/// Initialises Firebase services, which runs our authentication
/// (Authentication), database (Firestore Database)
/// Also initialises Flutter Stripe for payment (does not actually charge people
/// due to nature of project)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:orbital_nus/Authentication/Pages/splash_page.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  // Initialise firebase as a database
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51LJ9VMLYNfP77TLP4lTTBxog2LKizzmwuWG60b5WWtERbrD0TognQNZbqRPPQTNDn0YCposGAykV6Q6XNpFKvrjb00McBQjSkN";
  await Stripe.instance.applySettings();
  await Firebase.initializeApp(
      name: 'pickup-NUS',
      options: const FirebaseOptions(
          apiKey: 'AIzaSyDtb5aA78YgCAFqMrDBboQ9lxOjh5_VnzI',
          appId: '1:416661094567:android:659754b041fe43711d9b82',
          messagingSenderId: '416661094567',
          projectId: 'pickup-nus'));

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
