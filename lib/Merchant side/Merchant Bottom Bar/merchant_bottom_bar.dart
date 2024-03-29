/// Bottom bar widget displayed for the merchant pages
/// displayed and provides buttons to redirect to merchant orders page,
/// open/close restaurant page and profile page
///
/// @param selectMenu shows and highlights the respective pages that is selected

import 'package:flutter/material.dart';
import 'package:orbital_nus/Merchant%20side/Merchant%20Home%20Page/merchant_home_page.dart';
import 'package:orbital_nus/Merchant%20side/Profile/merchant_profile_page.dart';
import 'package:orbital_nus/Merchant%20side/open_for_order_page.dart';
import 'package:orbital_nus/colors.dart';

class MerchantBottomBar extends StatelessWidget {
  const MerchantBottomBar({
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
              spreadRadius: 2.0),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Home button
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MerchantHomePage(),
              ));
            },
            icon: Icon(
              Icons.home_outlined,
              color: MenuState.orders == selectMenu
                  ? kSecondaryColor
                  : Colors.grey,
              size: 30,
            ),
          ),

          // Open button
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const OpenForOrderPage()));
            },
            icon: Icon(
              Icons.meeting_room_outlined,
              color:
                  MenuState.open == selectMenu ? kSecondaryColor : Colors.grey,
              size: 30,
            ),
          ),

          // Profile button
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MerchantProfilePage()));
            },
            icon: Icon(
              Icons.person_outline,
              color: MenuState.profile == selectMenu
                  ? kSecondaryColor
                  : Colors.grey,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}

/// Provides the navigation to the 3 of merchant's main pages
/// Parameters to be inputted in MerchantBottomBar function
enum MenuState { orders, open, profile }
