/// Widget box that indicates the information of individual orders for merchant
/// to make
/// through order_list_view.dart in merchant_home_page.dart
/// shows order item name, buyer name, quantity, requests, order timestamp and
/// order number
///
/// @param orderId id of the order that is being shown on the widget box

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orbital_nus/colors.dart';
import 'package:orbital_nus/get_information/get_order.dart';

class MerchantOrderBox extends StatefulWidget {
  final String orderId;

  MerchantOrderBox(this.orderId);

  @override
  State<MerchantOrderBox> createState() => _MerchantOrderBoxState();
}

class _MerchantOrderBoxState extends State<MerchantOrderBox> {
  // Placeholder to store information about the order
  Order order = Order();
  DateTime? orderTime;

  /// Obtains information from database about the order based on the inputted
  /// orderId and update order and orderTime variable
  Future getOrderInfo() async {
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(widget.orderId)
        .get()
        .then((value) {
      order = Order.fromMap(value.data());
      orderTime = value.data()!['orderTime'].toDate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getOrderInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            height: 110,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 10,
                      right: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name of the food item
                        Row(
                          children: [
                            Text(
                              '${order.itemName}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        // Name of Buyer
                        Row(
                          children: [
                            Text(
                              'Ordered by: ${order.buyerName}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),

                        // Quantity of food item ordered
                        Row(
                          children: [
                            const Text(
                              'Quantity: ',
                              style: TextStyle(
                                color: Color.fromARGB(86, 0, 0, 0),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${order.quantity}',
                              style: const TextStyle(
                                color: Color.fromARGB(86, 0, 0, 0),
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),

                        // Instructions
                        Row(
                          children: [
                            const Text(
                              'Requests: ',
                              style: TextStyle(
                                color: Color.fromARGB(86, 0, 0, 0),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${order.instructions}',
                              style: const TextStyle(
                                color: Color.fromARGB(86, 0, 0, 0),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),

                        // Timestamp when order was placed
                        Row(
                          children: [
                            const Text(
                              'Order Time: ',
                              style: TextStyle(
                                color: Color.fromARGB(86, 0, 0, 0),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              // Show only the date and the time (up to seconds)
                              orderTime.toString().substring(0, 19),
                              style: const TextStyle(
                                color: Color.fromARGB(86, 0, 0, 0),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Order number
                Container(
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      ' ${order.orderNum} ',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
