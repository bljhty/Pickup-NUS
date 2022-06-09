// Widget to select which place (location) in NUS to order from
// displayed in restaurant_directory_page.dart

import 'package:flutter/material.dart';
import '../../get_information/place.dart';

class PlaceSelect extends StatelessWidget {
  final int selected;
  final Function callback;
  final Place place;

  PlaceSelect(this.selected, this.callback, this.place);

  @override
  Widget build(BuildContext context) {
    // category lists out the different locations available
    final category = place.stalls.keys.toList();

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
              color: Colors.white70,
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
