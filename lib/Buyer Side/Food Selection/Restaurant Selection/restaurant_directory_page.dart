/// Page to select the restaurant that are available for order
/// and it is categorised based on their place/location
/// Upon clicking on to the restaurant box, redirects buyer to restaurant's
/// order directory page
///
/// Serves as the home page of buyer upon logging in

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orbital_nus/Buyer%20Side/Components/bottom_bar.dart';
import 'package:orbital_nus/get_information/get_restaurant.dart';
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
  // For selection of the various restaurants
  var selected = 0;
  final pageController = PageController();

  // Placeholder for list of restaurants available for order
  List<Restaurant> restaurants = [];

  // Placeholder map listing the locations as key and the list of restaurants in said location
  Map<String, List<Restaurant>> places = {};

  /// Obtains information from database the restaurants available for order
  /// Updates restaurants variable, which is then sorted and updates places
  /// variable
  Future getRestaurants() async {
    await FirebaseFirestore.instance
        .collection('restaurants')
        .where('isOpenForOrder', isEqualTo: true)
        .get()
        .then((snapshot) => snapshot.docs.forEach((restaurant) {
              restaurants.add(Restaurant.fromMap(restaurant.data()));
            }));

    // Sorting the restaurants based on location in map places
    restaurants.forEach((restaurant) {
      if (places[restaurant.place!] == null) {
        // create an empty list if its new place
        places[restaurant.place!] = [];
      }
      // Add current restaurant to the correct list based on their location
      addRestaurant(restaurant);
    });
  }

  /// Checks through whether restaurant already exists within places,
  /// if it exists, do not add restaurant into places,
  /// else add restaurant into places
  addRestaurant(Restaurant restaurant) {
    for (int i = 0; i < places[restaurant.place!]!.length; i++) {
      if (restaurant.merchantId == places[restaurant.place!]![i].merchantId) {
        return;
      }
    }
    // Checked through the list and no duplicates, add onto the list
    places[restaurant.place!]?.add(restaurant);
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
      bottomNavigationBar: const BottomBar(selectMenu: MenuState.home),
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
