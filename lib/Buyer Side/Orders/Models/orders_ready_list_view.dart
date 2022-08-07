/// Widget showing scrolling list of order boxes
/// for the orders made by buyer that are ready for collection
/// displayed in orders_page.dart
///
/// Contains button below order box for buyer to indicate that it has been
/// collected by buyer
///
/// @param pageController Controller for the page to select the food item
/// @orderIds List of order Ids that are ready for the buyer

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orbital_nus/Buyer%20Side/Orders/models/order_ready_box.dart';
import 'package:orbital_nus/colors.dart';

class OrdersReadyListView extends StatefulWidget {
  final PageController pageController;
  final List<dynamic> orderIds;

  OrdersReadyListView(
    this.pageController,
    this.orderIds,
  );

  @override
  State<OrdersReadyListView> createState() => _OrdersReadyListViewState();
}

class _OrdersReadyListViewState extends State<OrdersReadyListView> {
  /// Updates database of order to indicate order is collected
  /// upon pressing the 'Collected' button
  /// removes order box once database is updated
  ///
  /// @param orderId Id of order that has been collected
  Future updateOrderCollected(String orderId) async {
    await FirebaseFirestore.instance.collection('orders').doc(orderId).update({
      'isOrderCollected': true,
      'collectedTime': FieldValue.serverTimestamp(),
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
                child: OrderReadyBox(widget.orderIds[index]),
              ),

              // Collected button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: () {
                    updateOrderCollected(widget.orderIds[index]);
                  }, // to change the status of the order
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: kSecondaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Collected',
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
