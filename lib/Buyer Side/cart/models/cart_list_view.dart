// Provides a list view of the food items currently in the cart
// at cart_page.dart

import 'package:flutter/material.dart';
import 'package:orbital_nus/Buyer%20Side/cart/edit_order_page.dart';
import 'package:orbital_nus/colors.dart';
import 'cart_item.dart';

class CartListView extends StatelessWidget {
  final PageController pageController;
  final List<dynamic> orderIds;

  CartListView(this.pageController, this.orderIds);

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
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditOrderPage(orderIds[index]),
              ));
            },
            child: CartItem(orderIds[index]),
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
