// Main page to order food, after clicking the order button

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orbital_nus/Buyer%20Side/Components/Bottom_bar.dart';
import 'package:orbital_nus/Buyer%20Side/Components/enum.dart';
import 'package:orbital_nus/Buyer%20Side/get_information/get_food.dart';
import 'package:orbital_nus/Buyer%20Side/get_information/get_restaurant.dart';
import 'package:orbital_nus/Buyer%20Side/Order%20pages/food%20directory/models/food_list.dart';
import 'package:orbital_nus/Buyer%20Side/Order%20pages/food%20directory/models/restaurant_info.dart';
import 'package:orbital_nus/colors.dart';
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
  // variables used for the selection and scrolling of the food items
  var selected = 0;
  final pageController = PageController();

  // Obtaining relevant food item data tagged to the merchant Id from database
  // List of foods available for the specific restaurant
  List<Food> foods = [];

  // List of foods ordered based on menuType
  Map<String, List<Food>> foodsByType = {};

  // obtain database of foods for particular merchant as class Food
  // and store in list foods
  Future getFoods() async {
    await FirebaseFirestore.instance
        .collection('foods')
        .where('merchantId',
            isEqualTo: widget.restaurant
                .merchantId) // foods pertaining to specific merchantId only
        .get()
        .then((snapshot) => snapshot.docs.forEach((food) {
              // for each item, to form it into class Food and add into list foods
              foods.add(Food.fromMap(food.data()));
            }));

    // sort the foods into foodsByType based on the item's menuType
    foods.forEach((food) {
      if (foodsByType[food.menuType!] == null) {
        // create an empty list if its a new menuType
        foodsByType[food.menuType!] = [];
      }
      // add current food into the list of the menuType
      addFood(food);
    });
  }

  // function to check if food is a duplicate, if it isn't add onto the list
  addFood(Food food) {
    for (int i = 0; i < foodsByType[food.menuType!]!.length; i++) {
      if (food.itemId == foodsByType[food.menuType!]![i].itemId) {
        return;
      }
    }
    // checked through the list and no duplicates, add onto the list
    foodsByType[food.menuType!]?.add(food);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      bottomNavigationBar: const Bottombar(
        selectMenu: MenuState.home,
      ),
      body: FutureBuilder(
        future: getFoods(), // wait to compile foods
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                }, foodsByType.keys.toList()),

                // List of available food in the page selected
                // uses food_list_view.dart as widget
                Expanded(
                  child: FoodListView(selected, (int index) {
                    setState(() {
                      selected = index;
                    });
                  }, pageController, foodsByType.keys.toList(), foodsByType),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
