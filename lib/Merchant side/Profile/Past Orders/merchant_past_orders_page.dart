/// Page listing the past orders that the restaurant has completed
/// past orders defined as orders that have been collected by buyers
/// orders are listed with the most recent being on the top and oldest being at
/// the bottom
/// Page can be assessed via the 'Past Orders' button in the merchant's profile
/// page

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_nus/Buyer%20Side/Settings/Past%20Orders/Models/past_order_list_view.dart';
import 'package:orbital_nus/colors.dart';
import 'package:orbital_nus/get_information/get_username.dart';

class MerchantPastOrdersPage extends StatefulWidget {
  const MerchantPastOrdersPage({Key? key}) : super(key: key);

  @override
  State<MerchantPastOrdersPage> createState() => _MerchantPastOrdersPageState();
}

class _MerchantPastOrdersPageState extends State<MerchantPastOrdersPage> {
  final pageController = PageController();

  // Placeholders to store information
  Username userInfo = Username();
  List<String> pastOrders = [];

  /// Obtain information from database about the logged in merchant and
  /// its orders completed (orders placed, ready and collected) sorted by
  /// descending date
  /// updates userInfo and pastOrders variables
  Future getPastOrders() async {
    // Obtain information about logged in buyer
    final user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        .get()
        .then((value) {
      userInfo = Username.fromMap(value.data());
    });

    // Obtain list of past orders and store in pastOrders
    await FirebaseFirestore.instance
        .collection('orders')
        .where('merchantId', isEqualTo: userInfo.id)
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
          'Order history',
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
