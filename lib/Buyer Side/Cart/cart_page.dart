/// Page showing each order item in the buyer's cart
/// Clicking on each order brings buyer to its edit order page
/// Has checkout button to pay and submit order to relevant restaurants

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_nus/Buyer%20Side/Components/bottom_bar.dart';
import 'package:orbital_nus/Buyer%20Side/Orders/orders_page.dart';
import 'package:orbital_nus/get_information/get_username.dart';
import 'package:orbital_nus/colors.dart';
import 'models/cart_list_view.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

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
  num totalPrice = 0; // to store the total price of the whole cart

  /// Obtains the subPrice of each order in the cart from database
  /// based on the values stored in orderIds variable
  /// and updates totalPrice for each order
  Future getTotalPrice() async {
    // get the subPrice of each order and include into totalPrice
    orderIds.forEach((orderId) async {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId)
          .get()
          .then((value) {
        num subPrice = value.data()!['subPrice'];
        totalPrice += subPrice;
      });
    });
  }

  /// Obtains information about the order based on the current user's database
  /// and updates orderIds variable
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

    // obtain the total cost of the whole cart
    getTotalPrice();
  }

  /// Updates the database to submit the order to the relevant merchant for the
  /// food to be made
  /// and empty the cart of the current user
  /// once database is updated, popup message is shown that it is successful
  /// and buyer is directed to orders page
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

  @override
  Widget build(BuildContext context) {
    /// Pop up for the payment of the cart items once checkout button is pressed
    /// As pickup@NUS is just a prototype, a dummy card is provided to
    /// all buyers to 'pay' for the orders,
    /// application is set so no charge would also be made in any way
    ///
    /// if payment is successful, orders will be submitted to merchants
    /// else error message to popup
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

        // submit order to kitchen and clear the cart
        submitCart();
      } catch (e) {
        if (e is StripeException) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Error from stripe')));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Error: $e')));
        }
      }
    }

    return Scaffold(
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
      bottomNavigationBar: const BottomBar(selectMenu: MenuState.cart),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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

      // Checkout button
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
                'Checkout',
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
                email: 'example@gmail.com', amount: (totalPrice * 100).toInt());
          },
        ),
      ),
    );
  }
}
