// Box listing the information of the restaurant that is pending approval
// based on the restaurantId displayed in admin_home_page.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orbital_nus/get_information/get_restaurant.dart';

class ApprovalBox extends StatefulWidget {
  final String restaurantId;

  ApprovalBox(this.restaurantId);

  @override
  State<ApprovalBox> createState() => _ApprovalBoxState();
}

class _ApprovalBoxState extends State<ApprovalBox> {
  // placeholder to store information about the restaurant
  Restaurant restaurant = Restaurant();

  // initialise restaurant information
  Future getRestaurant() async {
    await FirebaseFirestore.instance
        .collection('restaurants')
        .doc(widget.restaurantId)
        .get()
        .then((value) {
      restaurant = Restaurant.fromMap(value.data());
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getRestaurant(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
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
                        // Name of the Restaurant
                        Row(
                          children: [
                            Text(
                              '${restaurant.merchantName}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        // location of restaurant
                        Row(
                          children: [
                            Text(
                              '${restaurant.place}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
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
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
