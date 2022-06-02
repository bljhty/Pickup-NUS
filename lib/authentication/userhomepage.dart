// Homepage once user is logged in

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_nus/authentication/pages/login_screen.dart';
import '../Order/Order_directory_page.dart';
import 'mainpage.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  // Sign out procedure
  Future signOut() async {
    // Alert message that user has signed out (not working)
    showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button
        builder: (context) => AlertDialog(
              title: const Text('Are you sure you want to Sign Out?'),
              actions: [
                // confirm button
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          // signs user out
                          FirebaseAuth.instance.signOut();
                          // redirects back to login page once alert message is closed
                          return const MainPage();
                        }),
                      );
                    },
                    child: const Text('Confirm')),

                // cancel button
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel')),
              ],
            ));
  }

  @override
  // placeholder text (center of the screen)
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Signed in as: ${user.email!}'),
          // order button (something wrong here it is not updating)
          MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const OrderDirectoryPage();
                }),
              );
            },
            color: Colors.orangeAccent,
            child: const Text('Order here'),
          ),

          //sign out button
          MaterialButton(
            onPressed: () {
              signOut();
            },
            color: Colors.blueGrey,
            child: const Text('Sign Out'),
          )
        ],
      ),
    ));
  }
}
