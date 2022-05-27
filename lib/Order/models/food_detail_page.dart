import 'package:flutter/material.dart';
import 'package:orbital_nus/Order/models/food_detail_image.dart';
import 'package:orbital_nus/Order/models/food_info.dart';
import 'food.dart';

// The page shown of specific food after clicking on it in the food directory menu
class FoodDetailPage extends StatelessWidget {
  final Food food;

  FoodDetailPage(this.food);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SingleChildScrollView(
        child: Column(
          children: [
            FoodImg(food), // food image
            FoodInfo(food), // food information
          ],
        ),
      ),
      // add to cart button
      floatingActionButton: SizedBox(
        width: 250,
        height: 56,
        child: RawMaterialButton(
          fillColor: Colors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(Icons.shopping_bag_outlined,
              color: Colors.white,
              size: 30,),
              const Text('Add to Cart',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle
                  ),
                child: Text(food.quantity.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),),
              ),
            ],
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
