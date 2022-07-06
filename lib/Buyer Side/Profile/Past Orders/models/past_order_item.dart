// indicates the descriptions of the specific past orders
// through past_order_list_view.dart in past_order_page.dart

import 'package:flutter/material.dart';
import 'package:orbital_nus/get_information/get_order.dart';

class PastOrderItem extends StatelessWidget {
  final Order order;

  PastOrderItem(this.order);

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
                  // name of item
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Name of the food item
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
                      // Quantity of the food item ordered
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
}
