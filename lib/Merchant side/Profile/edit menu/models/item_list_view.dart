// lists out the food on the menu to edit in edit_menu_page.dart

import 'package:flutter/material.dart';
import 'package:orbital_nus/Merchant%20side/Profile/edit%20menu/models/item_box.dart';
import 'package:orbital_nus/Buyer%20Side/get_information/get_food.dart';
import 'package:orbital_nus/Merchant%20side/Profile/edit%20menu/models/edit_item_page.dart';
import 'package:orbital_nus/colors.dart';

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
                      // uses food_item.dart to show how the food item is laid out
                      child: ItemBox(foods[menuType[selected]]![index])),
                  separatorBuilder: (_, index) => const SizedBox(
                        height: 15,
                      ),
                  itemCount: foods[menuType[selected]]!.length))
              .toList()),
    );
  }
}
