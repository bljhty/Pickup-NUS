/// Page displaying buyer's orders that have been checked out
/// orders that are ready for collection are at top half of page
/// orders that are being prepared are at bottom half of screen

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_nus/Buyer%20Side/Components/bottom_bar.dart';
import 'package:orbital_nus/Buyer%20Side/Orders/models/orders_preparing_list_view.dart';
import 'package:orbital_nus/Buyer%20Side/Orders/models/orders_ready_list_view.dart';
import 'package:orbital_nus/get_information/get_username.dart';
import 'package:orbital_nus/colors.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final pageControllerPreparing = PageController();
  final pageControllerReady = PageController();

  // Placeholders to store information needed
  Username userInfo = Username();

  // Placeholder list of orderIds being prepared
  List<dynamic> orderIdsPreparing = [];

  // Placeholder list of orderIds that are ready for collection
  List<dynamic> orderIdsReady = [];

  /// Obtains information from database about the buyer, and list of orders
  /// buyer is waiting for
  /// updates userInfo, orderIdsPreparing and orderIdsReady
  Future getOrders() async {
    // Obtain information about logged in buyer
    final user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        .get()
        .then((value) {
      userInfo = Username.fromMap(value.data());
    });

    // Obtain orderIds that are being prepared
    await FirebaseFirestore.instance
        .collection('orders')
        .where('buyerId', isEqualTo: userInfo.id)
        .where('isOrderPlaced', isEqualTo: true)
        .where('isOrderReady', isEqualTo: false)
        .orderBy('orderTime', descending: false)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (orderId) {
              orderIdsPreparing.add(orderId.reference.id);
            },
          ),
        );

    // Obtain orderIds that are ready for collection
    await FirebaseFirestore.instance
        .collection('orders')
        .where('buyerId', isEqualTo: userInfo.id)
        .where('isOrderReady', isEqualTo: true)
        .where('isOrderCollected', isEqualTo: false)
        .orderBy('orderTime', descending: false)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (orderId) {
              orderIdsReady.add(orderId.reference.id);
            },
          ),
        );
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
          "My Orders",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(selectMenu: MenuState.orders),
      body: FutureBuilder(
        future: getOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // List of foods ready for collection
                Container(
                  width: double.maxFinite,
                  height: 40,
                  color: Colors.grey,
                  alignment: Alignment.center,
                  child: const Text(
                    'Ready for Collection:',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                Expanded(
                  child:
                      OrdersReadyListView(pageControllerReady, orderIdsReady),
                ),

                // List of foods being prepared
                Container(
                  width: double.maxFinite,
                  height: 40,
                  color: Colors.grey,
                  alignment: Alignment.center,
                  child: const Text(
                    'Being prepared:',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                Expanded(
                  child: OrdersPreparingListView(
                      pageControllerPreparing, orderIdsPreparing),
                ),
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
