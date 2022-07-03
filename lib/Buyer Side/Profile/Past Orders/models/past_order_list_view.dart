// Provides a list view of the past orders from the buyer

import 'package:flutter/material.dart';
import 'package:orbital_nus/Buyer%20Side/Profile/Past%20Orders/models/past_order_item.dart';
import 'package:orbital_nus/colors.dart';
import 'package:orbital_nus/get_information/get_order.dart';

class PastOrderListView extends StatelessWidget {
  final PageController pageController;
  final List<Order> pastOrders;

  PastOrderListView(this.pageController,
      this.pastOrders,);

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
            return const SizedBox(height: 12,);
          },
          itemCount: pastOrders.length,
      ),
    );
  }
}
