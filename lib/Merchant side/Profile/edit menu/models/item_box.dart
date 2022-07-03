// display of each food item on edit_item_page.dart
// through item_list_view.dart

import 'package:flutter/material.dart';
import 'package:orbital_nus/Buyer%20Side/get_information/get_food.dart';

class ItemBox extends StatelessWidget {
  final Food food;

  ItemBox(this.food);

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

                        // arrow icon to indicate that it can be clicked on
                        const Icon(
                          Icons.edit_outlined,
                          size: 15,
                        )
                      ],
                    ),
                    Row(
                      // price of the food item
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
                          style:
                          const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}