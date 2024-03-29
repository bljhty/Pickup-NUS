/// Widget displaying the price of food item being order and the order quantity
/// Order quantity can be adjusted via the '+' or '-' button
/// Displayed in edit_order_page.dart and food_detail_page.dart
/// via food_info.dart
///
/// @param food Information of the food item being ordered
/// @param order Information of the order being placed

import 'package:flutter/material.dart';
import 'package:orbital_nus/colors.dart';
import 'package:orbital_nus/get_information/get_food.dart';
import 'package:orbital_nus/get_information/get_order.dart';

class FoodPriceQuantity extends StatefulWidget {
  final Food food;
  final Order order;

  FoodPriceQuantity(this.food, this.order);

  @override
  State<FoodPriceQuantity> createState() => _FoodPriceQuantityState();
}

class _FoodPriceQuantityState extends State<FoodPriceQuantity> {
  int _qtyToOrder = 1;
  num _unitPrice = 0;
  num _subPrice = 0;

  @override
  void initState() {
    super.initState();
    // updates _qtyToOrder and _subPrice to reflect the last quantity changes of the order
    _qtyToOrder = int.parse(widget.order.quantity.toString());
    _unitPrice = num.parse(widget.food.price.toString());
    _subPrice = num.parse(
        (int.parse(widget.order.quantity.toString()) * _unitPrice)
            .toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 40,
      child: Stack(
        children: [
          // Text holder for price
          Align(
            alignment: const Alignment(-0.4, 0),
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
                  // Price of the food
                  const Text(
                    '\$',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.order.subPrice!.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Quantity display with slider
          Align(
            alignment: const Alignment(0.4, 0),
            child: Container(
              height: double.maxFinite,
              width: 120,
              decoration: BoxDecoration(
                color: kSecondaryColor,
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
                            // ensures quantity is never below 1
                            _qtyToOrder--;
                            _subPrice = num.parse(
                                (_qtyToOrder * _unitPrice).toStringAsFixed(2));
                            widget.order.quantity = _qtyToOrder;
                            widget.order.subPrice = _subPrice;
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
                          _subPrice = num.parse(
                              (_qtyToOrder * _unitPrice).toStringAsFixed(2));
                          widget.order.quantity = _qtyToOrder;
                          widget.order.subPrice = _subPrice;
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
