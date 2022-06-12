// Provides a list view of the food items currently in the cart
// at cart_page.dart

import 'package:flutter/material.dart';
import 'package:orbital_nus/Buyer Side/get_information/restaurant.dart';
import 'cart_item.dart';

class CartListView extends StatelessWidget {
  final int selected;
  final Function callback;
  final PageController pageController;
  final Restaurant restaurant;

  CartListView(
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
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () {},
                      child: CartItem(
                          restaurant.menu[category[selected]]![index]
                          )),
                  separatorBuilder: (_, index) => const SizedBox(
                        height: 15,
                      ),
                  itemCount: restaurant.menu[category[selected]]!.length))
              .toList()),
    );
  }
}
