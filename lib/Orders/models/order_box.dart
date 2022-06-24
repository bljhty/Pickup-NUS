// Box listing the information of the order that is
// based on the OrderId displayed in orders_page.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orbital_nus/Buyer%20Side/get_information/get_order.dart';

class OrderBox extends StatefulWidget {
  final String orderId;

  OrderBox(this.orderId);

  @override
  State<OrderBox> createState() => _OrderBoxState();
}

class _OrderBoxState extends State<OrderBox> {
  // placeholder to store information about the order
  Order order = Order();

  @override
  // initialise the order info
  void initState() {
    super.initState();
    // get order info
    FirebaseFirestore.instance
        .collection('orders')
        .doc(widget.orderId)
        .get()
        .then((value) {
      order = Order.fromMap(value.data());
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${order.itemName}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),

                // quantity of food item ordered
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
                        fontWeight: FontWeight.bold,
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
                      ),
                    ),
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
