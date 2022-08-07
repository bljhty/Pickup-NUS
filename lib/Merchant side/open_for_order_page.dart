/// Page providing buttons to open/close restaurant from incoming orders in
/// pickup@NUS
/// also includes the current status of the restaurant (whether opened/closed)
/// Upon the merchant logging in, they would be directed to this page

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_nus/Merchant%20side/Merchant%20Bottom%20Bar/merchant_bottom_bar.dart';
import 'package:orbital_nus/colors.dart';
import 'package:orbital_nus/get_information/get_restaurant.dart';
import 'package:orbital_nus/get_information/get_username.dart';

class OpenForOrderPage extends StatefulWidget {
  const OpenForOrderPage({Key? key}) : super(key: key);

  @override
  State<OpenForOrderPage> createState() => _OpenForOrderPageState();
}

class _OpenForOrderPageState extends State<OpenForOrderPage> {
  // Placeholder to obtain the userInfo of logged in user
  Username userInfo = Username();

  // Placeholder to display status of the restaurant
  String restaurantStatus = '';

  /// Obtain merchant's information from database and updates userInfo variable
  Future getUserInfo() async {
    final user = FirebaseAuth.instance.currentUser!;
    // Obtain the userInfo of logged in merchant
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        .get()
        .then((value) {
      userInfo = Username.fromMap(value.data());
    });

    // Initial check of the restaurant status
    await checkOpen();
  }

  /// Checks database for whether the restaurant is open or closed, and
  /// updates restaurantStatus
  Future checkOpen() async {
    await FirebaseFirestore.instance
        .collection('restaurants')
        .doc(userInfo.id)
        .get()
        .then((value) {
      Restaurant restaurant = Restaurant.fromMap(value.data());
      if (restaurant.isOpenForOrder == true) {
        restaurantStatus = 'Open';
      } else {
        restaurantStatus = 'Closed';
      }
    });
  }

  /// Updates database to indicate restaurant as open/closed
  ///
  /// @param toOpen status the merchant wants the restaurant to be in
  /// true if want to open, false is otherwise
  Future changeRestaurantStatus(bool toOpen) async {
    await FirebaseFirestore.instance
        .collection('restaurants')
        .doc(userInfo.id)
        .update({
      'isOpenForOrder': toOpen,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Open/Close Restaurant'),
      ),
      bottomNavigationBar: const MerchantBottomBar(selectMenu: MenuState.open),
      body: SafeArea(
        child: FutureBuilder(
          future: getUserInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Indication of whether the merchant is open/closed
                    const Text(
                      'You are currently',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    FutureBuilder(
                        future: checkOpen(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              restaurantStatus != '') {
                            return Text(
                              restaurantStatus,
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }
                          return const Text(
                            'loading...',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 50,
                    ),
                    // Open for Order
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: GestureDetector(
                        onTap: () {
                          changeRestaurantStatus(true);
                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Center(
                            child: Text(
                              'Open',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),

                    // Closed for Order
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: GestureDetector(
                        onTap: () {
                          changeRestaurantStatus(false);
                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Center(
                            child: Text(
                              'Close',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
