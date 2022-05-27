import 'package:flutter/material.dart';
import 'food.dart';
import 'food_price_quantity.dart';

// Widget showing what food it is and the price of it
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
          // name of the food
          Text(food.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // indicate wait time
              _buildIconText(
                  Icons.access_time_outlined,
                  Colors.blue,
                  food.waitTime
              ),
            ],
          ),
          const SizedBox(height: 30,),
          // Price of food and its quantity to add
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
          color: color,
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
