// Page to select the restaurant based on location

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orbital_nus/Buyer%20Side/Components/Bottom_bar.dart';
import 'package:orbital_nus/Buyer%20Side/Components/enum.dart';
import 'package:orbital_nus/Buyer%20Side/get_information/get_restaurant.dart';
import 'package:orbital_nus/colors.dart';
import 'models/place_select.dart';
import 'models/restaurant_list_view.dart';

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

  // Obtaining relevant places for order from database
  // List of restaurants available for order
  List<Restaurant> restaurants = [];

  // Map listing the locations as key and the list of restaurants in said location
  Map<String, List<Restaurant>> places = {};

  // obtain database of restaurants & add into list restaurants
  Future getRestaurants() async {
    await FirebaseFirestore.instance
        .collection('restaurants')
        .where('isOpenForOrder', isEqualTo: true)
        .get()
        .then((snapshot) => snapshot.docs.forEach((restaurant) {
              restaurants.add(Restaurant.fromMap(restaurant.data()));
            }));

    // sorting the restaurants based on location in map places
    restaurants.forEach((restaurant) {
      if (places[restaurant.place!] == null) {
        // create an empty list if its new place
        places[restaurant.place!] = [];
      }
      // add current restaurant to the correct list based on their location
      places[restaurant.place!]?.add(restaurant);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: const Text(
          'Select Restaurant',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: const Bottombar(selectMenu: MenuState.home),
      body: FutureBuilder(
        future: getRestaurants(), // wait to compile places
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bar to select the locations to order from
                // uses place_select.dart
                PlaceSelect(selected, (int index) {
                  setState(() {
                    selected = index;
                  });
                  pageController.jumpToPage(index);
                }, places),

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
                    places,
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
