// displays how each food item looks in the boxes
// on restaurant_directory_page.dart through restaurant_list_view.dart

import 'package:flutter/material.dart';
import 'package:orbital_nus/Buyer Side/get_information/get_restaurant.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantItem(this.restaurant);

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
          // Logo of the restaurant
          Container(
            padding: const EdgeInsets.all(5),
            width: 110,
            height: 110,
            child: Image.asset(
              restaurant.logoUrl!,
              fit: BoxFit.fitHeight,
            ),
          ),

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
                        // Restaurant name
                        Text(
                          restaurant.merchantName!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),

                        // arrow icon to indicate that it can be clicked on
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                        )
                      ],
                    ),
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
