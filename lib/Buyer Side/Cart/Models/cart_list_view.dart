/// Widget presenting a scrolling list of order boxes from cart_item
/// displayed in cart_page.dart
///
/// @param pageController pageController page controller from the page
/// @param orderIds list of Ids of orders that are in the cart
/// @return a scrolling widget containing boxes of orders in the cart
/// and when any order box is clicked, would be directed to the order's
/// edit order page

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
