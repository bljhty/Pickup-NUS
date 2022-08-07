/// Widget showing scrolling list of food item boxes
/// for the food items in the selected menuType of the restaurant
/// displayed in order_directory_page.dart
///
/// Upon pressing on the specific food item box, buyer would be directed to
/// food item's food detail page to order food item
///
/// @param selected Menu type that is selected to be displayed
/// @param callback Function to update the widget to the correct items listed
/// based on the menu type chosen
/// @param pageController Controller for the page to select the food items
/// @param menuType List of menu types available in the restaurant
/// @param foods List of food items available categorised by their menu type

import 'package:flutter/material.dart';
import 'package:orbital_nus/Buyer%20Side/Food%20Selection/Food%20Details/food_detail_page.dart';
import 'package:orbital_nus/colors.dart';
import 'package:orbital_nus/get_information/get_food.dart';
import 'food_item.dart';

class FoodListView extends StatelessWidget {
  final int selected;
  final Function callback;
  final PageController pageController;
  final List<String> menuType;
  final Map<String, List<Food>> foods;

  FoodListView(this.selected, this.callback, this.pageController, this.menuType,
      this.foods);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: PageView(
          controller: pageController,
          onPageChanged: (index) => callback(index),
          children: menuType
              .map((e) => ListView.separated(
                  padding: EdgeInsets.zero,
                  // Upon tap, redirects to the specific food_detail_page.dart
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FoodDetailPage(
                                foods[menuType[selected]]![index])));
                      },
                      // Uses food_item.dart to show how the food item is laid out
                      child: FoodItem(foods[menuType[selected]]![index])),
                  separatorBuilder: (_, index) => const SizedBox(
                        height: 15,
                      ),
                  itemCount: foods[menuType[selected]]!.length))
              .toList()),
    );
  }
}
