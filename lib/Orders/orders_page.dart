import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_nus/Buyer%20Side/get_information/get_username.dart';
import 'package:orbital_nus/Components/Bottom_bar.dart';
import 'package:orbital_nus/Components/enum.dart';
import 'package:orbital_nus/Orders/models/orders_preparing_list_view.dart';
import 'package:orbital_nus/Orders/models/orders_ready_list_view.dart';
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

  // to store list of orderIds being prepared
  List<dynamic> orderIdsPreparing = [];

  // to store list of orderIds that are ready for collection
  List<dynamic> orderIdsReady = [];

  // to obtain the orders by buyer being prepared/ready for collection
  Future getOrders() async {
    // obtain information about logged in buyer
    final user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        .get()
        .then((value) {
      userInfo = Username.fromMap(value.data());
    });

    // obtain orderIds that are being prepared
    await FirebaseFirestore.instance
        .collection('orders')
        .where('buyerId', isEqualTo: userInfo.id)
        .where('isOrderPlaced', isEqualTo: true)
        .where('isOrderReady', isEqualTo: false)
        .get()
        .then((snapshot) =>
        snapshot.docs.forEach(
              (orderId) {
            orderIdsPreparing.add(orderId.reference.id);
          },
        ),
    );

    // obtain orderIds that are ready for collection
    await FirebaseFirestore.instance
        .collection('orders')
        .where('buyerId', isEqualTo: userInfo.id)
        .where('isOrderReady', isEqualTo: true)
        .where('isOrderCollected', isEqualTo: false)
        .get()
        .then((snapshot) =>
        snapshot.docs.forEach(
              (orderId) {
            orderIdsReady.add(orderId.reference.id);
          },
        ),
    );
    // if i put setState, it is gonna continue running and keep adding on to the list
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
      body: FutureBuilder(
        future: getOrders(),
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // List of foods being prepared
              Container(
                width: double.maxFinite,
                height: 40,
                color: Colors.grey,
                alignment: Alignment.centerLeft,
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
                    pageControllerPreparing,
                    orderIdsPreparing
                ),
              ),

              // List of foods ready for collection
              Container(
                width: double.maxFinite,
                height: 40,
                color: Colors.grey,
                alignment: Alignment.centerLeft,
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
                child: OrdersReadyListView(
                  pageControllerReady,
                  orderIdsReady
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: const Bottombar(
        selectMenu: MenuState.orders,
      ),
    );
  }
}
