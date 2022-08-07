/// Widget showing scrolling list of restaurant boxes
/// for the restaurants available for order in the selected place
/// displayed in order_directory_page.dart
///
/// Upon pressing on the specific restaurant box, buyer would be redirected to
/// restaurant's order directory page for buyers to look at its menu
///
/// @param selected Place/Location that is selected to be displayed
/// @param callback Function to update the widget to the correct restaurants for
/// the location
/// @param pageController Controller for the page to select the restaurant
/// @param places List of places/location available for order

import 'package:flutter/material.dart';
import 'package:orbital_nus/Buyer%20Side/Food%20Selection/Food%20Directory/order_directory_page.dart';
import 'package:orbital_nus/colors.dart';
import 'package:orbital_nus/get_information/get_restaurant.dart';
import 'restaurant_item.dart';

class RestaurantListView extends StatelessWidget {
  final int selected;
  final Function callback;
  final PageController pageController;
  final Map<String, List<Restaurant>> places;

  RestaurantListView(
      this.selected, this.callback, this.pageController, this.places);

  @override
  Widget build(BuildContext context) {
    // Lists out all the different locations available
    final category = places.keys.toList();

    return Container(
      color: kBackgroundColor,
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      child: PageView(
          controller: pageController,
          onPageChanged: (index) => callback(index),
          children: category
              .map((e) => ListView.separated(
                    padding: EdgeInsets.zero,
                    // Upon tap, redirects to the restaurant's order_directory_page.dart
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OrderDirectoryPage(
                                restaurant:
                                    places[category[selected]]![index])));
                      },
                      // Uses restaurant_item.dart to lay out how each box looks like
                      child: RestaurantItem(places[category[selected]]![index]),
                    ),
                    separatorBuilder: (_, index) => const SizedBox(height: 15),
                    itemCount: places[category[selected]]!.length,
                  ))
              .toList()),
    );
  }
}
