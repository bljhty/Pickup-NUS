// Page to select the restaurant based on location

import 'package:flutter/material.dart';
import 'package:orbital_nus/Components/Bottom_bar.dart';
import '../Components/enum.dart';
import 'cart_page.dart';
import 'models/Widgets/restaurant selection/place_select.dart';
import 'models/Widgets/restaurant selection/restaurant_list_view.dart';
import 'models/get_information/place.dart';

class RestaurantDirectoryPage extends StatefulWidget {
  const RestaurantDirectoryPage({Key? key}) : super(key: key);

  @override
  State<RestaurantDirectoryPage> createState() =>
      _RestaurantDirectoryPageState();
}

class _RestaurantDirectoryPageState extends State<RestaurantDirectoryPage> {
  // for selection of the various restaurants
  var selected = 0;
  final pageController = PageController();
  final place = Place.generatePlace();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const Bottombar(
        selectMenu: MenuState.home,
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        title: const Text(
          'Select Restaurant',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bar to select the locations to order from
          // uses place_select.dart
          PlaceSelect(selected, (int index) {
            setState(() {
              selected = index;
            });
            pageController.jumpToPage(index);
          }, place),

          // List of the available restaurants in
          // the particular location selected in PlaceSelect
          Expanded(
              child: RestaurantListView(
            selected,
            (int index) {
              setState(() {
                selected = index;
              });
            },
            pageController,
            place,
          )),
        ],
      ),
    );
  }
}
