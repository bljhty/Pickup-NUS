// Widget to select which place (location) in NUS to order from
// displayed in restaurant_directory_page.dart

import 'package:flutter/material.dart';
import 'package:orbital_nus/get_information/get_restaurant.dart';

class PlaceSelect extends StatelessWidget {
  final int selected;
  final Function callback;
  final Map<String, List<Restaurant>> places;

  PlaceSelect(this.selected, this.callback, this.places);

  @override
  Widget build(BuildContext context) {
    // category lists out the different locations available
    final category = places.keys.toList();

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
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              category[index],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        separatorBuilder: (_, index) => const SizedBox(
          width: 20,
        ),
        itemCount: category.length,
      ),
    );
  }
}
