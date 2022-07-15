// List containing boxes (order_box) that displays
// information of orders that are ready for collection
// displayed in orders_page.dart

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

  // updates the order to indicate that it has been collected
  Future updateOrderCollected(String orderId) async {
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(orderId)
        .update({
      'isOrderCollected': true,
      'collectedTime': FieldValue.serverTimestamp(),
    });
    // remove the orderId from the list
    widget.orderIds.remove(orderId);
    setState(() {}); // to reload the page
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        controller: widget.pageController,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {},
                child: OrderReadyBox(widget.orderIds[index]),
              ),

              // button to indicate order has been made
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
            // Order Collected button
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
