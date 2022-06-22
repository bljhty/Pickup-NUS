// Page to view the food items in the cart and to finalize the orders

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_nus/Buyer%20Side/get_information/get_username.dart';
import 'package:orbital_nus/Components/Bottom_bar.dart';
import 'package:orbital_nus/Components/enum.dart';
import 'package:orbital_nus/colors.dart';
import 'models/cart_list_view.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const Bottombar(
        selectMenu: MenuState.home,
      ),
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
      body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // list of items ordered (to be completed)
              FutureBuilder(
                future: getCart(),
                builder: (context, snapshot) {
                  return Expanded(
                    child: CartListView(
                      pageController,
                      orderIds,
                    ),
                  );
                }
              )
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
          onPressed: () {},
        ),
      ),
    );
  }
}
