/// Widget bar to select menu type from logged in restaurant
/// displayed in edit_menu_page.dart
///
/// @param selected Input of what menu type is selected and shown
/// @param callback Function executed upon clicking the different menu types
/// @param menuType List of menu types listed for the logged in restaurant

import 'package:flutter/material.dart';

class MenuTypeList extends StatelessWidget {
  final int selected;
  final Function callback;
  final List<String> menuType;

  MenuTypeList(this.selected, this.callback, this.menuType);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
              onTap: () => callback(index),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
