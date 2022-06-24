// List containing boxes (order_box) that displays
// information of orders that are ready for collection
// displayed in orders_page.dart

import 'package:flutter/material.dart';
import 'package:orbital_nus/Orders/models/order_box.dart';
import 'package:orbital_nus/colors.dart';

class OrdersReadyListView extends StatelessWidget {
  final PageController pageController;
  final List<dynamic> orderIds;

  OrdersReadyListView(
    this.pageController,
    this.orderIds,
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
                    child: OrderBox(orderIds[index]),
                  ),
                ],

              // Order Collected button
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 12);
        },
        itemCount: orderIds.length,
      ),
    );
  }
}
