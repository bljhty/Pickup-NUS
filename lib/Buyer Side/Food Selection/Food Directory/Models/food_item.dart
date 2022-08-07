/// Widget box showing information of specific food item
/// displayed on order_directory_page.dart
/// through food_list_view.dart
///
/// @param food Information of food item being displayed

import 'package:flutter/material.dart';
import 'package:orbital_nus/get_information/get_food.dart';

class FoodItem extends StatelessWidget {
  final Food food;

  FoodItem(this.food);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // image of the food
          Container(
              padding: const EdgeInsets.all(5),
              width: 110,
              height: 110,
              child: Image.asset(
                food.imgUrl!,
                fit: BoxFit.fitHeight,
              )),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                top: 20,
                left: 10,
                right: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Food name
                      Text(
                        food.itemName!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                        ),
                      ),

                      // Arrow icon indicating that it can be clicked on
                      const Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 15,
                      ),
                    ],
                  ),
                  Row(
                    // Price of food item
                    children: [
                      const Text(
                        '\$',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${food.price}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
