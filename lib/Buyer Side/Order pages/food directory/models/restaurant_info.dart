// Displays information about the restaurant selected
// Store name, waiting time, location and logo

import 'package:flutter/material.dart';
import 'package:orbital_nus/colors.dart';
import 'package:orbital_nus/get_information/get_restaurant.dart';

class RestaurantInfo extends StatelessWidget {
  final Restaurant restaurant;
  RestaurantInfo(this.restaurant);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      margin: const EdgeInsets.only(top: 0),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          // 1st row:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 1st Column: Name of stall
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.merchantName!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // 2nd Column: wait time, distance
                  Row(
                    children: [
                      // Location of restaurant
                      Text(
                        restaurant.place!,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10,),
                    ],
                  )
                ],
              ),

              // 2nd row, stall logo
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  restaurant.logoUrl!,
                  width: 100,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
