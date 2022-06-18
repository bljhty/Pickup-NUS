import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:orbital_nus/authentication/mainpage.dart';
import 'package:orbital_nus/authentication/pages/splash_page.dart';
import 'authentication/pages/login_screen.dart';


void main() async {
  // Initialise firebase as a database
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'pickup-NUS',
    options: const FirebaseOptions(
        apiKey: 'AIzaSyDtb5aA78YgCAFqMrDBboQ9lxOjh5_VnzI',
        appId: '1:416661094567:android:659754b041fe43711d9b82',
        messagingSenderId: '416661094567',
        projectId: 'pickup-nus'
    )
  );

  // fetch the restaurants available from firebase

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
      home: Splashscreen(),
    );
  }
}
