// Box listing the information of the order that is
// based on the OrderId displayed in orders_page.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orbital_nus/colors.dart';
import 'package:orbital_nus/get_information/get_order.dart';
import 'package:orbital_nus/get_information/get_restaurant.dart';

class OrderReadyBox extends StatefulWidget {
  final String orderId;

  OrderReadyBox(this.orderId);

  @override
  State<OrderReadyBox> createState() => _OrderReadyBoxState();
}

class _OrderReadyBoxState extends State<OrderReadyBox> {
  // placeholder to store information about the order
  Order order = Order();
  DateTime? orderTime;
  DateTime? readyTime;

  // placeholder to store information about the restaurant
  Restaurant restaurantInfo = Restaurant();

  // initialise order information
  Future getOrderInfo() async {
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(widget.orderId)
        .get()
        .then((value) {
      order = Order.fromMap(value.data());
      orderTime = value.data()!['orderTime'].toDate();
      readyTime = value.data()!['readyTime'].toDate();
    });

    // obtain information about the restaurant ordered from
    await FirebaseFirestore.instance
        .collection('restaurants')
        .doc(order.merchantId)
        .get()
        .then((value) {
      restaurantInfo = Restaurant.fromMap(value.data());
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
                      top: 10,
                      left: 10,
                      right: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name of the food item
                        Row(
                          children: [
                            // item name
                            Text(
                              '${order.itemName}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        // Restaurant name
                        Row(
                          children: [
                            Text(
                              '${restaurantInfo.place} - ${restaurantInfo.merchantName}',
                              style: const TextStyle(
                                fontSize: 14,
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
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              // show only the date and the time (up to seconds)
                              orderTime.toString().substring(0, 19),
                              style: const TextStyle(
                                color: Color.fromARGB(86, 0, 0, 0),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),

                        // Timestamp when order was ready
                        Row(
                          children: [
                            const Text(
                              'Ready Time: ',
                              style: TextStyle(
                                color: Color.fromARGB(86, 0, 0, 0),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              // show only the date and the time (up to seconds)
                              readyTime.toString().substring(0, 19),
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

                //Order number
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
