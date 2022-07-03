// Lists out the orders that are required to be made that were ordered in
// displayed in merchant_home_page.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orbital_nus/Buyer%20Side/Orders/models/order_box.dart';
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
  // updates the order for the user to show it is ready for collection
  Future updateOrderReady(String orderId) async {
    await FirebaseFirestore.instance.collection('orders').doc(orderId).update({
      'isOrderReady': true,
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
          controller: widget.pageController,
          padding: const EdgeInsets.all(12),
          itemBuilder: (context, index) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: OrderBox(widget.orderIds[index]),
                ),

                // button to indicate order has been made
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
          itemCount: widget.orderIds.length),
    );
  }
}
