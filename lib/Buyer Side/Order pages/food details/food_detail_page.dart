// Page showing the food details about the specific food,
// upon clicking on it in the order directory page,
// also where they can add item to cart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_nus/Buyer%20Side/Order%20pages/food%20details/models/food_info.dart';
import 'package:orbital_nus/Buyer%20Side/Order%20pages/restaurant%20selection/restaurant_directory_page.dart';
import 'package:orbital_nus/colors.dart';
import 'package:orbital_nus/get_information/get_food.dart';
import 'package:orbital_nus/get_information/get_order.dart';
import 'package:orbital_nus/get_information/get_username.dart';
import 'models/food_add_on.dart';
import 'models/food_detail_image.dart';

class FoodDetailPage extends StatefulWidget {
  final Food food;

  FoodDetailPage(this.food);

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  //obtain information of current buyer based on log in info
  final user = FirebaseAuth.instance.currentUser!;

  // obtain buyerId and buyerName from database
  Username userInfo = Username();

  // order class to store the information
  Order order = Order(
      quantity: 1, // if not updated, put as 1
      isOrderPlaced: false,
      isOrderReady: false,
      isOrderCollected: false);

  Future addToCart() async {
    // obtain information about the logged in buyer
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        .get()
        .then((value) {
      userInfo = Username.fromMap(value.data());
      order.buyerName = userInfo.name;
      order.buyerId = userInfo.id;
    });

    // create a new document of orders
    // obtain the newly generated orderId
    final getorderId = FirebaseFirestore.instance.collection('orders').doc();

    // Store the order Id as a string
    String orderId = '';
    await getorderId.get().then((value) {
      orderId = value.reference.id;
      // input the first 4 characters as the order number
      order.orderNum = orderId.substring(0, 4);
    });

    // map into database the order
    await getorderId.set(order.toMap());

    // input the order into the list of the user's cart
    await FirebaseFirestore.instance
        .collection('buyer')
        .doc(order.buyerId)
        .update({
      'cart': FieldValue.arrayUnion([orderId]),
    });

    // popup alert showing that order has been added to cart (not working)
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text('Added to cart!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const RestaurantDirectoryPage(),
                  )); // change to redirect to home
                },
                child: const Text('Close'),
              )
            ],
          );
        });
  }

  @override
  initState() {
    super.initState();
    // input all the information from food class into order class
    order.merchantId = widget.food.merchantId;
    order.itemName = widget.food.itemName;
    order.itemId = widget.food.itemId;
    order.subPrice = widget.food.price;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
          "Details",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // image of the food item
            // uses food_detail_image.dart
            FoodImg(widget.food),

            // information about the food
            //uses food_info.dart

            FoodInfo(widget.food, order), // food information
            const SizedBox(
              height: 50,
            ),

            // Additional instructions
            FoodAddOn(order),
          ],
        ),
      ),

      // Add to Cart button
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
                'Add to Cart',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
            ],
          ),
          // Add items to cart and update the database
          onPressed: () {
            addToCart();
          },
        ),
      ),
    );
  }
}
