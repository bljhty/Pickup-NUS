/// Page showing the orders the restaurant needs to make for buyers
/// from the order that were made earliest being placed on top and orders latest
/// placed at the bottom
/// when order has been made, merchant to click on the 'Ready' button below the
/// order to indicate to buyer that their order is ready for collection

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_nus/Merchant%20side/Merchant%20Bottom%20Bar/merchant_bottom_bar.dart';
import 'package:orbital_nus/Merchant%20side/Merchant%20Home%20Page/Models/orders_list_view.dart';
import 'package:orbital_nus/colors.dart';
import 'package:orbital_nus/get_information/get_username.dart';

class MerchantHomePage extends StatefulWidget {
  const MerchantHomePage({Key? key}) : super(key: key);

  @override
  State<MerchantHomePage> createState() => _MerchantHomePageState();
}

class _MerchantHomePageState extends State<MerchantHomePage> {
  PageController pageController = PageController();

  // Placeholders to store information needed
  Username userInfo = Username();

  // Placeholders to store list of orderIds to be prepared
  List<dynamic> orderIds = [];

  /// Obtains information from database for information of merchant
  /// list of order Ids required to be prepared and updates userInfo and
  /// orderIds variables
  /// To sort order Ids, with older orders listing first
  Future getOrders() async {
    // Obtain information about logged in merchant
    final user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        .get()
        .then((value) {
      userInfo = Username.fromMap(value.data());
    });

    // Obtain orderIds that needs to be made by merchant
    await FirebaseFirestore.instance
        .collection('orders')
        .where('merchantId', isEqualTo: userInfo.id)
        .where('isOrderPlaced', isEqualTo: true)
        .where('isOrderReady', isEqualTo: false)
        .orderBy('orderTime', descending: false)
        .get()
        .then((snapshot) => snapshot.docs.forEach((orderId) {
              orderIds.add(orderId.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: const Text(
          'Incoming Orders',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar:
          const MerchantBottomBar(selectMenu: MenuState.orders),
      body: FutureBuilder(
        future: getOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // List of foods that were ordered to be made
                Expanded(child: OrdersListView(pageController, orderIds)),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
