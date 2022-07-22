// Navigates the user to the correct home page according to their userType

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_nus/Admin%20Side/Admin%20Home%20Page/admin_home_page.dart';
import 'package:orbital_nus/Buyer%20Side/Order%20pages/restaurant%20selection/restaurant_directory_page.dart';
import 'package:orbital_nus/authentication/mainpage.dart';
import 'package:orbital_nus/get_information/get_username.dart';
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
  }

  // Function to direct merchants to the correct pages according to whether they
  // are approved by the administrator
  Future merchantDirectory() async {
    // obtain merchant's adminApproval from database
    String adminApproval = '';
    await FirebaseFirestore.instance
        .collection('restaurants')
        .doc(userInfo.id)
        .get()
        .then((value) {
      adminApproval = value.data()!['adminApproval'];
    });

    // based on the adminApproval, direct them to the correct page
    String message = '';
    if (adminApproval == 'Approved') {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const OpenForOrder();
      }));
      return;
    }
    // not approved, log out and provide alert message
    else if (adminApproval == 'Pending') {
      message =
          'Your account is pending approval from our administrators, please try again later';
    } else {
      message =
          'Your account is not approved, please contact our administrators for more information';
    }

    showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut(); // logout user
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const MainPage();
                  }));
                },
                child: const Text('Close'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserType(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // check for userType
          if (userInfo.userType == 'Merchant') {
            merchantDirectory();
          } else if (userInfo.userType == 'Admin') {
            return const AdminHomePage();
          } else {
            return const RestaurantDirectoryPage();
          }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
