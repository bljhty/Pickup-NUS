import 'package:flutter/material.dart';
import 'package:orbital_nus/Order/models/food_list.dart';
import 'package:orbital_nus/Order/models/restaurant_info.dart';
import 'models/restaurant.dart';
import 'package:orbital_nus/Order/models/food_list_view.dart';

class OrderDirectoryPage extends StatefulWidget {
  const OrderDirectoryPage({Key? key}) : super(key: key);

  @override
  State<OrderDirectoryPage> createState() => _OrderDirectoryPageState();
}

class _OrderDirectoryPageState extends State<OrderDirectoryPage> {
  var selected = 0;
  final pageController = PageController();
  final restaurant = Restaurant.generateRestaurant();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // include the AppBar
          RestaurantInfo(),
          FoodList(selected, (int index) {
            setState(() {
              selected = index;
            });
            pageController.jumpToPage(index);
          }, restaurant),
          Expanded(
            child: FoodListView(
              selected,
              (int index) {
                setState(() {
                  selected = index;
                });
              },
              pageController,
              restaurant,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        elevation: 2,
        child: Icon(
          Icons.shopping_bag_outlined,
          color: Colors.black,
          size: 30,
        ),
      ),
    );
  }
}
