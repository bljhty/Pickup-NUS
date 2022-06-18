// Widget bar to select the type of food in the menu i.e. Mains, Sides, etc.
// used in order_directory_page.dart

import 'package:flutter/material.dart';

class FoodList extends StatelessWidget {
  final int selected;
  final Function callback;
  final List<String> menuType;

  FoodList(this.selected, this.callback, this.menuType);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
              onTap: () => callback(index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Text(
                  menuType[index],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
          separatorBuilder: (_, index) => const SizedBox(width: 20),
          itemCount: menuType.length),
    );
  }
}
