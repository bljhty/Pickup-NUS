/// Bottom bar widget displayed for the buyer pages
/// displayed and provides buttons to redirect to restaurant directory page,
/// orders page, cart page and settings page
///
/// @param selectMenu shows and highlights the respective pages that is selected

import 'package:flutter/material.dart';
import 'package:orbital_nus/Buyer%20Side/Food%20Selection/Restaurant%20Selection/restaurant_directory_page.dart';
import 'package:orbital_nus/Buyer%20Side/Orders/orders_page.dart';
import 'package:orbital_nus/Buyer%20Side/Settings/settings_page.dart';
import 'package:orbital_nus/Buyer%20Side/cart/cart_page.dart';
import 'package:orbital_nus/colors.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
    required this.selectMenu,
  }) : super(key: key);
  final MenuState selectMenu;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 2.0,
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Home button
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RestaurantDirectoryPage()));
            },
            icon: Icon(Icons.home_outlined,
                color: MenuState.home == selectMenu
                    ? kSecondaryColor
                    : Colors.grey,
                size: 30),
          ),

          // Orders button
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const OrdersPage()));
            },
            icon: Icon(Icons.receipt_long_outlined,
                color: MenuState.orders == selectMenu
                    ? kSecondaryColor
                    : Colors.grey,
                size: 30),
          ),

          // Cart button
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CartPage()));
            },
            icon: Icon(Icons.shopping_cart_outlined,
                color: MenuState.cart == selectMenu
                    ? kSecondaryColor
                    : Colors.grey,
                size: 30),
          ),

          // Profile button
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsPage()));
            },
            icon: Icon(Icons.settings,
                color: MenuState.profile == selectMenu
                    ? kSecondaryColor
                    : Colors.grey,
                size: 30),
          ),
        ],
      ),
    );
  }
}

/// Provides the navigation to the 4 of buyer's main pages
/// Parameters to be inputted in BottomBar function
enum MenuState { profile, home, orders, cart }
