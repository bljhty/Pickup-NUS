// Lists out the orders that are required to be made that were ordered in
// displayed in merchant_home_page.dart

import 'package:flutter/material.dart';
import 'package:orbital_nus/Orders/models/order_box.dart';
import 'package:orbital_nus/colors.dart';

class OrdersListView extends StatelessWidget {
  final PageController pageController;
  final List<dynamic> ordersIds;

  OrdersListView(
    this.pageController,
    this.ordersIds,
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
            return Column(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: OrderBox(ordersIds[index]),
                )
              ],
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 12);
          },
          itemCount: ordersIds.length),
    );
  }
}
