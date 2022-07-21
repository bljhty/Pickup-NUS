// Page to view the food items in the cart and to finalize the orders

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_nus/Buyer%20Side/Components/Bottom_bar.dart';
import 'package:orbital_nus/Buyer%20Side/Orders/orders_page.dart';
import 'package:orbital_nus/get_information/get_username.dart';
import 'package:orbital_nus/colors.dart';
import '../../authentication/pages/paymentpage.dart';
import 'models/cart_list_view.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

/*
  Cart page which contains orders which are being added in by users by receiving
  the data that is stored in the data base to update their orders respectively
*/

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final pageController = PageController();

  // Placeholders to store information of user
  Username userInfo = Username();
  List<dynamic> orderIds = []; // to store list of orderIds of buyer's cart

  // to obtain the cart of the buyer
  Future getCart() async {
    // obtain information about logged in buyer
    final user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        .get()
        .then((value) {
      userInfo = Username.fromMap(value.data());
    });
    await FirebaseFirestore.instance
        .collection('buyer')
        .doc(userInfo.id)
        .get()
        .then((value) {
      final buyerInfo = value.data() as Map<String, dynamic>;
      orderIds = buyerInfo['cart'];
    });
  }

  // to update the database to submit the order to merchant and empty the cart
  Future submitCart() async {
    // update database to submit the orders (i.e. change isOrderPlaced to true and put timestamp)
    for (var orderId in orderIds) {
      FirebaseFirestore.instance.collection('orders').doc(orderId).update({
        "isOrderPlaced": true,
        "orderTime": FieldValue.serverTimestamp(),
      });
    }

    // empty the cart of the buyer (i.e. remove list of orderIds from cart)
    FirebaseFirestore.instance.collection('buyer').doc(userInfo.id).update({
      "cart": FieldValue.arrayRemove(orderIds),
    });

    // Navigate to OrderPage and show alert message that order has been placed
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const OrdersPage(),
    ));
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Order sent!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  // Alert dialog pop up to confirm submitting order
  Future confirmSubmission() async {
    showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text('Confirm Submit Order?'),
            actions: <Widget>[
              //confirm button
              TextButton(
                onPressed: () {
                  submitCart();
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

  @override
  Widget build(BuildContext context) {
    Future<void> initPaymentSheet(context,
        {required String email, required int amount}) async {
      try {
        final response = await http.post(
            Uri.parse(
                'https://us-central1-pickup-nus.cloudfunctions.net/stripePaymentIntentRequest'),
            body: {
              'email': email,
              'amount': amount.toString(),
            });
        final jsonResponse = jsonDecode(response.body);
        log(jsonResponse.toString());

        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: jsonResponse['paymentIntent'],
          merchantDisplayName: 'pickup@nus',
          customerId: jsonResponse['customer'],
          customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
          style: ThemeMode.light,
          testEnv: true,
          merchantCountryCode: 'SG',
        ));
        await Stripe.instance.presentPaymentSheet();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('payment completed')),
        );
      } catch (e) {
        if (e is StripeException) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Error from stripe')));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Error: $e')));
        }
      }
    }

    return Scaffold(
      // AppBar with back button and my cart text
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'My Cart',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: const Bottombar(selectMenu: MenuState.cart),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // list of items ordered (to be completed)
          FutureBuilder(
            future: getCart(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Expanded(
                  child: CartListView(
                    pageController,
                    orderIds,
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),

      // Order button
      floatingActionButton: SizedBox(
        width: 250,
        height: 56,
        child: RawMaterialButton(
          fillColor: kSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Order',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
            ],
          ),
          onPressed: () async {
            await initPaymentSheet(context,
                email: 'example@gmail.com', amount: 1000);
            confirmSubmission();
          },
        ),
      ),
    );
  }
}
