/// Widget showing scrolling list of order boxes
/// for the past orders made by the buyer, that has already been collected
/// displayed in past_order_page.dart
///
/// @param pageController Controller for the page to view the food items
/// @param pastOrders List of past orders made by buyer

import 'package:flutter/material.dart';
import 'package:orbital_nus/Buyer%20Side/Settings/Past%20Orders/Models/past_order_item.dart';
import 'package:orbital_nus/colors.dart';

class PastOrderListView extends StatelessWidget {
  final PageController pageController;
  final List<String> pastOrders;

  PastOrderListView(
    this.pageController,
    this.pastOrders,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.separated(
        controller: pageController,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          return PastOrderItem(pastOrders[index]);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 12,
          );
        },
        itemCount: pastOrders.length,
      ),
    );
  }
}
