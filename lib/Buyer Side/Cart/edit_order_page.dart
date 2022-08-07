/// Page for editing/deleting the current order and
/// its details
///
/// @param orderId Id of the order that is being edited

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orbital_nus/Buyer%20Side/Food%20Selection/Food%20Details/Models/food_add_on.dart';
import 'package:orbital_nus/Buyer%20Side/Food%20Selection/Food%20Details/Models/food_detail_image.dart';
import 'package:orbital_nus/Buyer%20Side/Food%20Selection/Food%20Details/Models/food_info.dart';
import 'package:orbital_nus/Buyer%20Side/cart/cart_page.dart';
import 'package:orbital_nus/get_information/get_food.dart';
import 'package:orbital_nus/get_information/get_order.dart';
import 'package:orbital_nus/colors.dart';

class EditOrderPage extends StatefulWidget {
  final String orderId;

  EditOrderPage(this.orderId);

  @override
  State<EditOrderPage> createState() => _EditOrderPageState();
}

class _EditOrderPageState extends State<EditOrderPage> {
  // holder to input the order information
  Order order = Order();

  // holder to input the food information
  Food food = Food();

  /// Obtains information about the order and its item information based on the
  /// input orderId from database and updates the order and the food variable
  Future getOrder() async {
    // obtain information about the order
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(widget.orderId)
        .get()
        .then((value) {
      order = Order.fromMap(value.data());
    });

    // obtain information about the food
    await FirebaseFirestore.instance
        .collection('foods')
        .doc(order.itemId)
        .get()
        .then((value) {
      food = Food.fromMap(value.data());
    });
  }

  /// Updates the database of input orderId with the updated order
  /// information upon clicking the update cart button
  ///
  /// Provides a success popup message once database is updated, and buyer is
  /// redirected back to the cart page
  Future updateCart() async {
    // update order accordingly into corresponding orderId
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(widget.orderId)
        .set(order.toMap());

    // popup alert showing that order has been updated
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text('Cart updated!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CartPage()));
                },
                child: const Text('Close'),
              )
            ],
          );
        });
  }

  /// Provides a popup notification to confirm deleting of input order
  /// upon clicking the delete button
  /// If confirmed, will proceed to delete order,
  /// else buyer would return to the edit order page
  Future deleteOrderNotif() async {
    // provide popup message to confirm deleting order
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text('Confirm Deletion?'),
            actions: <Widget>[
              TextButton(
                // confirm button
                onPressed: () {
                  deleteOrder();
                },
                child: const Text('Confirm'),
              ),
              // cancel button
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
            ],
          );
        });
  }

  /// Deletes and removes specific order from the buyer's cart and database
  /// After deleting, buyer would be redirected back to their cart
  Future deleteOrder() async {
    // delete order from 'orders' collection
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(widget.orderId)
        .delete()
        .then(
          (doc) => print('document deleted'),
          onError: (e) => print('error updating document $e'),
        );

    // delete specific orderId from cart of buyer
    await FirebaseFirestore.instance
        .collection('buyer')
        .doc(order.buyerId)
        .update({
      "cart": FieldValue.arrayRemove([widget.orderId]),
    });

    // navigate to cart page
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const CartPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
          'Edit Order',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          // delete button
          IconButton(
            onPressed: () {
              deleteOrderNotif();
            },
            icon: const Icon(
              Icons.delete_rounded,
            ),
            alignment: Alignment.center,
          )
        ],
      ),
      body: FutureBuilder(
          future: getOrder(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    // image of the food item
                    FoodImg(food),

                    // information about the food
                    FoodInfo(food, order),
                    const SizedBox(
                      height: 50,
                    ),

                    // Additional instructions
                    FoodAddOn(order),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: SizedBox(
        width: 200,
        height: 56,
        child: RawMaterialButton(
          fillColor: kSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Icon(
                Icons.shopping_bag_outlined,
                color: Colors.white,
                size: 30,
              ),
              Text(
                'Update Cart',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
            ],
          ),
          // Update order in the database
          onPressed: () {
            updateCart();
          },
        ),
      ),
    );
  }
}
