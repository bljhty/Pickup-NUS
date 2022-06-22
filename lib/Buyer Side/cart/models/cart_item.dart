// indicates the specific descriptions of the food items in the cart
// through cart_list_view.dart in cart_page.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orbital_nus/Buyer%20Side/get_information/get_order.dart';

class CartItem extends StatefulWidget {
  final String orderId;

  CartItem(this.orderId);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {

  Order order = Order();

  @override
  void initState() {
    super.initState();
    // get order info and store in order
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
        borderRadius: BorderRadius.circular(20),
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
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${order.quantity}',
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
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
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                            '${order.instructions}',
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            )
                        )
                      ],
                    ),
                    // price of food item
                    Row(
                      children: [
                        // Subprice of the food item
                        const Text(
                          'Subprice: \$',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                          ),
                        ),
                        Text(
                          '${order.subPrice}',
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
