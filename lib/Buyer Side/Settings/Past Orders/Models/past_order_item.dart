/// Widget box that indicates the information of the order completed by buyer
/// displayed in past_order_page.dart through past_order_list_view.dart
/// shows food name, quantity, instructions, order timestamp, ready timestamp,
/// collected timestamp and sub price
///
/// @param orderId Id of order that is being shown in the widget box
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orbital_nus/get_information/get_order.dart';

class PastOrderItem extends StatefulWidget {
  final String orderId;

  PastOrderItem(this.orderId);

  @override
  State<PastOrderItem> createState() => _PastOrderItemState();
}

class _PastOrderItemState extends State<PastOrderItem> {
  // Placeholder to store information about the order
  Order order = Order();
  DateTime? orderTime;
  DateTime? readyTime;
  DateTime? collectedTime;

  /// Obtain information from database about the order, ordered time, ready
  /// time and collected time
  Future getOrderInfo() async {
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(widget.orderId)
        .get()
        .then((value) {
      order = Order.fromMap(value.data());
      orderTime = value.data()!['orderTime'].toDate();
      readyTime = value.data()!['readyTime'].toDate();
      collectedTime = value.data()!['collectedTime'].toDate();
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
                          // Name of food item
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
                              Text('${order.instructions}',
                                  style: const TextStyle(
                                    color: Color.fromARGB(86, 0, 0, 0),
                                    fontSize: 12,
                                  ))
                            ],
                          ),

                          // Order time
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
                                orderTime.toString().substring(0, 19),
                                style: const TextStyle(
                                  color: Color.fromARGB(86, 0, 0, 0),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),

                          // Ready time
                          Row(
                            children: [
                              const Text(
                                'Ready Time: ',
                                style: TextStyle(
                                  color: Color.fromARGB(86, 0, 0, 0),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                readyTime.toString().substring(0, 19),
                                style: const TextStyle(
                                  color: Color.fromARGB(86, 0, 0, 0),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),

                          // Collected time
                          Row(
                            children: [
                              const Text(
                                'Collection Time: ',
                                style: TextStyle(
                                  color: Color.fromARGB(86, 0, 0, 0),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                collectedTime.toString().substring(0, 19),
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

                  // Price of the food item
                  Text(
                    '\$${order.subPrice?.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
