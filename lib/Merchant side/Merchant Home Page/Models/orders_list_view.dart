/// Widget showing scrolling list of order boxes
/// for the orders the restaurant are to prepare
/// displayed in merchant_home_page.dart
/// Contains a widget box for each order and a 'Ready' button to update that
/// order is ready for collection
///
/// @param pageController Controller for the page to select the food items
/// @param orderIds List of order Ids to be prepared by the restaurant

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orbital_nus/Merchant%20side/Merchant%20Home%20Page/models/merchant_order_box.dart';
import 'package:orbital_nus/colors.dart';

class OrdersListView extends StatefulWidget {
  final PageController pageController;
  final List<dynamic> orderIds;

  OrdersListView(
    this.pageController,
    this.orderIds,
  );

  @override
  State<OrdersListView> createState() => _OrdersListViewState();
}

class _OrdersListViewState extends State<OrdersListView> {
  /// Updates the order in database to show it is ready for collection
  /// when 'Ready' button is pressed
  /// Removes order from list once database is updated
  Future updateOrderReady(String orderId) async {
    await FirebaseFirestore.instance.collection('orders').doc(orderId).update({
      'isOrderReady': true,
      'readyTime': FieldValue.serverTimestamp(),
    });
    // Remove the orderId from the list
    widget.orderIds.remove(orderId);
    setState(() {}); // to reload the page
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.separated(
        controller: widget.pageController,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {},
                child: MerchantOrderBox(widget.orderIds[index]),
              ),

              // Ready button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: () {
                    updateOrderReady(widget.orderIds[index]);
                  }, // to change the status of the order
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Ready',
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
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 12);
        },
        itemCount: widget.orderIds.length,
      ),
    );
  }
}
