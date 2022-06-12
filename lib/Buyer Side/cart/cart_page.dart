// Page to view the food items in the cart and to finalize the orders

import 'package:flutter/material.dart';
import 'package:orbital_nus/Buyer Side/get_information/restaurant.dart';
import 'package:orbital_nus/Buyer%20Side/Order pages/restaurant%20selection/restaurant_directory_page.dart';
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
  var selected = 0;
  final pageController = PageController();
  final restaurant = Restaurant.generateRestaurant('TechnoEdge');

  // Alert message indicating order has been sent
  Future orderSubmittedNotif() => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            title: const Text('Order has been sent to the kitchen'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        // redirects back to user home page once message is closed
                        return const RestaurantDirectoryPage();
                      }),
                    );
                  },
                  child: const Text('Close'))
            ],
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const Bottombar(
        selectMenu: MenuState.home,
      ),
      // AppBar with back button and my cart text
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
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
          Expanded(
            child: CartListView(
              selected,
              (int index) {
                setState(() {
                  selected = index;
                });
              },
              pageController,
              restaurant[selected],
            ),
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
          onPressed: () {
            orderSubmittedNotif();
          },
        ),
      ),
    );
  }
}
