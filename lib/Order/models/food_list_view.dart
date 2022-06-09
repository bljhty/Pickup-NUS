// lists out the food on the menu available in order_directory_page.dart

import 'package:flutter/material.dart';
import 'package:orbital_nus/Order/models/food_detail_page.dart';
import 'package:orbital_nus/Order/models/get_information/restaurant.dart';
import 'food_item.dart';

class FoodListView extends StatelessWidget {
  final int selected;
  final Function callback;
  final PageController pageController;
  final Restaurant restaurant;

  FoodListView(
      this.selected, this.callback, this.pageController, this.restaurant);

  @override
  Widget build(BuildContext context) {
    final category = restaurant.menu.keys.toList();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: PageView(
          controller: pageController,
          onPageChanged: (index) => callback(index),
          children: category
              .map((e) => ListView.separated(
                  padding: EdgeInsets.zero,
                  // Upon tap, redirects to the specific food_detail_page.dart
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FoodDetailPage(
                                restaurant.menu[category[selected]]![index])));
                      },
                      // uses food_item.dart to show how the food item is layed out
                      child: FoodItem(
                          restaurant.menu[category[selected]]![index])),
                  separatorBuilder: (_, index) => const SizedBox(
                        height: 15,
                      ),
                  itemCount: restaurant.menu[category[selected]]!.length))
              .toList()),
    );
  }
}
