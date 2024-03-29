/// Widget providing information of the food item being ordered
/// includes item's name, wait time, price and quantity for order
/// displayed in edit_order_page.dart and food_detail_page.dart
///
/// @param food Information of the food item being ordered
/// @param order Information of the order being placed

import 'package:flutter/material.dart';
import 'package:orbital_nus/get_information/get_food.dart';
import 'package:orbital_nus/get_information/get_order.dart';
import 'food_price_quantity.dart';

class FoodInfo extends StatelessWidget {
  final Food food;
  final Order order;

  FoodInfo(this.food, this.order);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      color: Colors.white,
      child: Column(
        children: [
          // name of the food item
          Text(
            food.itemName!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(
            height: 15,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Waiting time
              _buildIconText(
                  Icons.access_time_outlined, Colors.blue, food.waitTime!),
            ],
          ),
          const SizedBox(
            height: 30,
          ),

          // Price of food and its quantity to add
          // uses food_price_quantity.dart as widget
          FoodPriceQuantity(food, order),
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
        Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
