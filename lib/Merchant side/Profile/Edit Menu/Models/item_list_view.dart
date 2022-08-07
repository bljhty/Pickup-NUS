/// Widget showing scrolling list of food items of the inputted menu type of the
/// buyer's menu
/// displayed in edit_menu_page.dart
/// upon clicking on specific food item, merchant redirected to edit item page
/// for specific food item
///
/// @param selected Menu type that was selected to display on the menu
/// @callback Function to update the widget to the correct food items listed
/// based on chosen menu type
/// @param menuType List of menu types available in the restaurant
/// @param foods List of food items available categorised by their menu type

import 'package:flutter/material.dart';
import 'package:orbital_nus/Merchant%20side/Profile/edit%20menu/models/item_box.dart';
import 'package:orbital_nus/Merchant%20side/Profile/edit%20menu/models/edit_item_page.dart';
import 'package:orbital_nus/colors.dart';
import 'package:orbital_nus/get_information/get_food.dart';

class ItemListView extends StatelessWidget {
  final int selected;
  final Function callback;
  final PageController pageController;
  final List<String> menuType;
  final Map<String, List<Food>> foods;

  ItemListView(this.selected, this.callback, this.pageController, this.menuType,
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
                  // Upon tap, redirects to the specific edit_item_page.dart
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditItemPage(
                                foods[menuType[selected]]![index])));
                      },
                      // Uses food_item.dart to show how the food item is laid out
                      child: ItemBox(foods[menuType[selected]]![index])),
                  separatorBuilder: (_, index) => const SizedBox(
                        height: 15,
                      ),
                  itemCount: foods[menuType[selected]]!.length))
              .toList()),
    );
  }
}
