// lists out the food on the menu available in order_directory_page.dart

import 'package:flutter/material.dart';
import 'package:orbital_nus/Buyer%20Side/Order%20pages/food%20details/food_detail_page.dart';
import 'package:orbital_nus/Buyer%20Side/get_information/get_food.dart';
import 'food_item.dart';

class FoodListView extends StatelessWidget {
  final int selected;
  final Function callback;
  final PageController pageController;
  final List<String> menuType;
  final Map<String, List<Food>> foods;

  FoodListView(
      this.selected, this.callback, this.pageController, this.menuType, this.foods);

  @override
  Widget build(BuildContext context) {

    return Container(
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
                      // uses food_item.dart to show how the food item is laid out
                      child: FoodItem(
                          foods[menuType[selected]]![index])),
                  separatorBuilder: (_, index) => const SizedBox(
                        height: 15,
                      ),
                  itemCount: foods[menuType[selected]]!.length))
              .toList()),
    );
  }
}
