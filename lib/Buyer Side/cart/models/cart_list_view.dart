// Provides a list view of the food items currently in the cart
// at cart_page.dart
import 'package:flutter/material.dart';
import 'cart_item.dart';

class CartListView extends StatelessWidget {
  final PageController pageController;
  final List<dynamic> orderIds;

  CartListView(this.pageController, this.orderIds);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: ListView.separated(
        controller: pageController,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          return CartItem(orderIds[index]);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 12);
        },
        itemCount: orderIds.length,
      ),
    );
  }
}
