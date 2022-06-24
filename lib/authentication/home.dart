// Navigates the user to the correct home page according to their userType

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_nus/Buyer%20Side/Order%20pages/restaurant%20selection/restaurant_directory_page.dart';
import 'package:orbital_nus/Buyer%20Side/get_information/get_username.dart';
import 'package:orbital_nus/Merchant%20side/open_for_order.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Placeholder for information about user that is logged in
  Username userInfo = Username();

  Future getUserType() async {
    final user = FirebaseAuth.instance.currentUser!;
    // obtain information from the database about the logged in user
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        .get()
        .then((value) {
      userInfo = Username.fromMap(value.data());
    });
    print('OVER HERE!');
    print(userInfo.userType);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserType(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // check for userType
          if (userInfo.userType == 'Merchant') {
            return const OpenForOrder();
          }
          return const RestaurantDirectoryPage();
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
