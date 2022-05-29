// Displays information about the restaurant selected
// Store name, waiting time, distance and logo

import 'package:flutter/material.dart';
import 'package:orbital_nus/Order/models/restaurant.dart';

class RestaurantInfo extends StatelessWidget {
  final restaurant = Restaurant.generateRestaurant();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
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
                    restaurant.merchantName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // 2nd Column: wait time, distance
                  Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(restaurant.waitTime,
                              style: const TextStyle(
                                color: Colors.white,
                              ))),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        restaurant.distance,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.withOpacity(0.4),
                        ),
                      ),
                    ],
                  )
                ],
              ),

              // 2nd row, stall logo
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  restaurant.logoURL,
                  width: 80,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
