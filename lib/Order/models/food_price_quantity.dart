// Indicate price and quantity of food in food_detail_page.dart

import 'package:flutter/material.dart';
import 'get_information/food.dart';

class FoodPriceQuantity extends StatefulWidget {
  final Food food;

  FoodPriceQuantity(this.food);

  @override
  State<FoodPriceQuantity> createState() => _FoodPriceQuantityState();
}

class _FoodPriceQuantityState extends State<FoodPriceQuantity> {
  int _qtyToOrder = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 40,
      child: Stack(
        children: [
          // Text holder for price
          Align(
            alignment: const Alignment(-0.3, 0),
            child: Container(
              width: 120,
              height: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(30),
              ),

              // Price text
              child: Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  // indicate the price of the food
                  const Text(
                    '\$',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.food.price.toString(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Widget to choose quantity with slider (to be completed)
          Align(
            alignment: const Alignment(0.3, 0),
            child: Container(
              height: double.maxFinite,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: double.maxFinite,
                    width: 40,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          if (_qtyToOrder != 1) {
                            _qtyToOrder--;
                            widget.food.quantity = _qtyToOrder;
                          }
                        });
                      },
                      child: const Text(
                        '-',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Text(
                      '$_qtyToOrder',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: double.maxFinite,
                    width: 40,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _qtyToOrder++;
                          widget.food.quantity = _qtyToOrder;
                        });
                      },
                      child: const Text(
                        '+',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
