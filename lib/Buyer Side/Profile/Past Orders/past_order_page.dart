// Page showing the buyers past orders

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_nus/Buyer%20Side/Profile/Past%20Orders/models/past_order_list_view.dart';
import 'package:orbital_nus/colors.dart';
import 'package:orbital_nus/get_information/get_order.dart';
import 'package:orbital_nus/get_information/get_username.dart';

class PastOrderPage extends StatefulWidget {
  const PastOrderPage({Key? key}) : super(key: key);

  @override
  State<PastOrderPage> createState() => _PastOrderPageState();
}

class _PastOrderPageState extends State<PastOrderPage> {
  final pageController = PageController();

  // Placeholders to store information
  Username userInfo = Username();
  List<String> pastOrders = [];

  Future getPastOrders() async {
    // obtain information about logged in buyer
    final user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        .get()
        .then((value) {
      userInfo = Username.fromMap(value.data());
    });

    // obtain list of past orders and store in pastOrders
    await FirebaseFirestore.instance
        .collection('orders')
        .where('buyerId', isEqualTo: userInfo.id)
        .where('isOrderCollected', isEqualTo: true)
        .orderBy('orderTime', descending: true)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (orderId) {
              pastOrders.add(orderId.reference.id);
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: const Text(
          'Past Orders',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: getPastOrders(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Expanded(
                  child: PastOrderListView(pageController, pastOrders),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }
}
