// Main page to order food, after clicking the order button

import 'package:flutter/material.dart';
import 'package:orbital_nus/Components/Bottom_bar.dart';
import 'package:orbital_nus/Buyer%20Side/Order%20pages/food%20directory/models/food_list.dart';
import 'package:orbital_nus/Buyer%20Side/Order%20pages/food%20directory/models/restaurant_info.dart';
import 'package:orbital_nus/Components/enum.dart';
import 'package:orbital_nus/colors.dart';
import '../../get_information/restaurant.dart';
import 'package:orbital_nus/Buyer%20Side/Order%20pages/food%20directory/models/food_list_view.dart';

class OrderDirectoryPage extends StatefulWidget {
  const OrderDirectoryPage({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final Restaurant restaurant;

  @override
  State<OrderDirectoryPage> createState() => _OrderDirectoryPageState();
}

class _OrderDirectoryPageState extends State<OrderDirectoryPage> {
  var selected = 0;
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      bottomNavigationBar: const Bottombar(
        selectMenu: MenuState.home,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TODO: include the appbar

          // Top information, regarding the food stall being ordered from
          // uses restaurant_info.dart as widget
          RestaurantInfo(widget.restaurant),

          // Bar to menuType, i.e. Mains, Sides, etc.
          // uses food_list.dart as widget
          FoodList(selected, (int index) {
            setState(() {
              selected = index;
            });
            pageController.jumpToPage(index);
          }, widget.restaurant),

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
              widget.restaurant,
            ),
          ),
        ],
      ),
    );
  }
}
