// Widget listing out the restaurants open for order
// Displayed in restaurant_directory_page.dart

import 'package:flutter/material.dart';
import 'package:orbital_nus/Buyer%20Side/models/Order%20pages/food%20directory/order_directory_page.dart';
import '../../../get_information/place.dart';
import 'restaurant_item.dart';

class RestaurantListView extends StatelessWidget {
  final int selected;
  final Function callback;
  final PageController pageController;
  final Place place;

  RestaurantListView(this.selected,
      this.callback,
      this.pageController,
      this.place);

  @override
  Widget build(BuildContext context) {
    //category lists out all the different locations available
    final category = place.stalls.keys.toList();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25,),
      child: PageView(
          controller: pageController,
          onPageChanged: (index) => callback(index),
          children: category
              .map((e) =>
              ListView.separated(
                padding: EdgeInsets.zero,
                // Upon tap, redirects to the restaurant's order_directory_page.dart
                itemBuilder: (context, index) =>
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                OrderDirectoryPage(
                                    restaurant: place.stalls[category[selected]]![index]
                                )
                        ));
                      },
                      // uses restaurant_item.dart to lay out how each box looks like
                      child: RestaurantItem(
                          place.stalls[category[selected]]![index]
                      ),
                    ),
                separatorBuilder: (_, index) =>
                const SizedBox(
                    height: 15
                ),
                itemCount: place.stalls[category[selected]]!.length,
              ))
              .toList()
      ),
    );
  }
}
