// Main page to order food, after clicking the order button

import 'package:flutter/material.dart';
import 'package:orbital_nus/Order/models/food_list.dart';
import 'package:orbital_nus/Order/models/restaurant_info.dart';
import 'cart_page.dart';
import 'models/restaurant.dart';
import 'package:orbital_nus/Order/models/food_list_view.dart';

class OrderDirectoryPage extends StatefulWidget {
  const OrderDirectoryPage({Key? key}) : super(key: key);

  @override
  State<OrderDirectoryPage> createState() => _OrderDirectoryPageState();
}

class _OrderDirectoryPageState extends State<OrderDirectoryPage> {
  var selected = 0;
  final pageController = PageController();
  final restaurant = Restaurant.generateRestaurant();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TODO: include the appbar

          // Top information, regarding the food stall being ordered from
          // uses restaurant_info.dart as widget
          RestaurantInfo(),

          // Bar to select Recommended page, popular page, etc.
          // uses food_list.dart as widget
          FoodList(selected, (int index) {
            setState(() {
              selected = index;
            });
            pageController.jumpToPage(index);
          }, restaurant),

          // List of available food in the page selected
          // uses food_list_view.dart as widget
          Expanded(
            child: FoodListView(
              selected,
              (int index) {
                setState(() {
                  selected = index;
                });
              },
              pageController,
              restaurant,
            ),
          )
        ],
      ),

      // View Cart button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return const CartPage();
            }),
          );
        },
        backgroundColor: Colors.orange,
        elevation: 2,
        child: const Icon(
          Icons.shopping_bag_outlined,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
