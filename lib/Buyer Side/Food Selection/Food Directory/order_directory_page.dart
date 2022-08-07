/// Page displaying information about the restaurant and its menu categorised
/// into their specific menu types (i.e. Mains, Sides, etc.)
/// Upon clicking on to item box of specific food item, redirects buyer to
/// food detail page
///
/// @param restaurant Information about the restaurant being displayed

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orbital_nus/Buyer%20Side/Components/bottom_bar.dart';
import 'package:orbital_nus/Buyer%20Side/Food%20Selection/Food%20Directory/Models/food_list.dart';
import 'package:orbital_nus/Buyer%20Side/Food%20Selection/Food%20Directory/Models/food_list_view.dart';
import 'package:orbital_nus/Buyer%20Side/Food%20Selection/Food%20Directory/Models/restaurant_info.dart';
import 'package:orbital_nus/get_information/get_food.dart';
import 'package:orbital_nus/get_information/get_restaurant.dart';
import 'package:orbital_nus/colors.dart';

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
  // Variables used for the selection and scrolling of the food items
  var selected = 0;
  final pageController = PageController();

  // Placeholder for list of foods available for the specific restaurant
  List<Food> foods = [];

  // Placeholder for list of foods ordered based on menuType
  Map<String, List<Food>> foodsByType = {};

  /// Obtains information from database the food items from the restaurant
  /// Updates food variable, which is then sorted and updates foodsByType
  /// variable
  Future getFoods() async {
    await FirebaseFirestore.instance
        .collection('foods')
        .where('merchantId',
            isEqualTo: widget.restaurant
                .merchantId) // Foods pertaining to specific merchantId only
        .get()
        .then((snapshot) => snapshot.docs.forEach((food) {
              // For each item, to form it into class Food and add into list foods
              foods.add(Food.fromMap(food.data()));
            }));

    // Sort the foods into foodsByType based on the item's menuType
    foods.forEach((food) {
      if (foodsByType[food.menuType!] == null) {
        // Create an empty list if its a new menuType
        foodsByType[food.menuType!] = [];
      }
      // Add current food into the list of the menuType
      addFood(food);
    });
  }

  /// Checks through whether food item already exists within foodsByType,
  /// if it exists, do not add food item,
  /// else add food item into foodsByType
  ///
  /// @param food information of the food item being checked
  addFood(Food food) {
    for (int i = 0; i < foodsByType[food.menuType!]!.length; i++) {
      if (food.itemId == foodsByType[food.menuType!]![i].itemId) {
        return;
      }
    }
    // Checked through the list and no duplicates, add onto the list
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
      bottomNavigationBar: const BottomBar(
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
