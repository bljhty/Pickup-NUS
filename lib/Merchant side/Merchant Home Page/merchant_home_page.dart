// Home page for merchants, indicates the orders that they have to make

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_nus/Merchant%20side/Merchant%20Bottom%20Bar/merchant_bottom_bar.dart';
import 'package:orbital_nus/Merchant%20side/Merchant%20Home%20Page/models/orders_list_view.dart';
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

  // to store list of orderIds to be prepared
  List<dynamic> orderIds = [];

  // to obtain the orderIds needed to be prepared
  Future getOrders() async {
    // obtain information about logged in merchant
    final user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        .get()
        .then((value) {
      userInfo = Username.fromMap(value.data());
    });

    // obtain orderIds that needs to be made by merchant
    await FirebaseFirestore.instance
        .collection('orders')
        .where('merchantId', isEqualTo: userInfo.id)
        .where('isOrderPlaced', isEqualTo: true)
        .where('isOrderReady', isEqualTo: false)
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
