// List containing boxes (order_box) that displays
// information of orders being prepared
// displayed in orders_page.dart

import 'package:flutter/material.dart';
import 'package:orbital_nus/Buyer%20Side/Orders/models/order_box.dart';
import 'package:orbital_nus/colors.dart';

class OrdersPreparingListView extends StatelessWidget {
  final PageController pageController;
  final List<dynamic> orderIds;

  OrdersPreparingListView(
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
          return GestureDetector(
            onTap: () {},
            child: OrderBox(orderIds[index]),
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
