// Page showing the food details about the specific food,
// upon clicking on it in the order directory page,
// also where they can add item to cart

import 'package:flutter/material.dart';
import 'package:orbital_nus/Order/models/food_detail_image.dart';
import 'package:orbital_nus/Order/models/food_info.dart';
import 'food_add_on.dart';
import 'get_information/food.dart';

// The page shown of specific food after clicking on it in the food directory menu
class FoodDetailPage extends StatelessWidget {
  final Food food;

  FoodDetailPage(this.food);

  // TODO: Alert message indicating order has been added to cart
  Future addedToCart() async {
    // TODO: update the database that order is added to cart
    showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Added to Cart!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // image of the food item
            // uses food_detail_image.dart
            FoodImg(food),

            // information about the food
            //uses food_info.dart
            FoodInfo(food), // food information
            const SizedBox(
              height: 50,
            ),

            // Additional instructions
            const FoodAddOn()
          ],
        ),
      ),

      // Add to Cart button
      floatingActionButton: SizedBox(
        width: 200,
        height: 56,
        child: RawMaterialButton(
          fillColor: Colors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Icon(
                Icons.shopping_bag_outlined,
                color: Colors.white,
                size: 30,
              ),
              Text(
                'Add to Cart',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
            ],
          ),
          // TODO: Shows Alert Message that item has been added to cart
          // and redirects back to order directory page
          onPressed: () {},
        ),
      ),
    );
  }
}
