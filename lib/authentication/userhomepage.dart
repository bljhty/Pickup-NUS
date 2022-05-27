import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Order/Order_directory_page.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  // placeholder text (center of the screen)
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Signed in as: ${user.email!}'),
              // order button (something wrong here it is not updating
              MaterialButton(onPressed: () {
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
              MaterialButton(onPressed: (){
                FirebaseAuth.instance.signOut();
              },
                color: Colors.blueGrey,
                child: const Text('Sign Out'),
              )
            ],
          ),
        )
    );
  }
}