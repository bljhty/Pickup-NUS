// initial information about the food right below the picture
// in food_detail_page.dart
// includes the food item picture, name, waiting time, price and quantity

import 'package:flutter/material.dart';
import '../../../get_information/food.dart';
import 'food_price_quantity.dart';

class FoodInfo extends StatelessWidget {
  final Food food;

  FoodInfo(this.food);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      color: Colors.white,
      child: Column(
        children: [
          // name of the food item
          Text(
            food.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 15,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Waiting time
              _buildIconText(
                  Icons.access_time_outlined,
                  Colors.blue,
                  food.waitTime
              ),
            ],
          ),
          const SizedBox(height: 30,),

          // Price of food and its quantity to add
          // uses food_price_quantity.dart as widget
          FoodPriceQuantity(food),
        ],
      ),
    );
  }

  // help to generate the description with its intended icon and its color
  Widget _buildIconText(IconData icon, Color color, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.grey,
          size: 20,
        ),
        Text(text,
          style: const TextStyle(
              fontSize: 16
          ),
        ),
      ],
    );
  }
}
