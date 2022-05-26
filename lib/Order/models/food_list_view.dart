import 'package:flutter/material.dart';
import 'package:orbital_nus/Order/models/food_detail.dart';
import 'package:orbital_nus/Order/models/restaurant.dart';
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
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: PageView(
          controller: pageController,
          onPageChanged: (index) => callback(index),
          children: category
              .map((e) => ListView.separated(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FoodDetailPage()));
                      },
                      child: FoodItem(
                          restaurant.menu[category[selected]]![index])),
                  separatorBuilder: (_, index) => SizedBox(
                        height: 15,
                      ),
                  itemCount: restaurant.menu[category[selected]]!.length))
              .toList()),
    );
  }
}
