import 'package:flutter/material.dart';
import 'package:orbital_nus/Buyer%20Side/cart/cart_page.dart';
import 'package:orbital_nus/Buyer%20Side/Order pages/restaurant%20selection/restaurant_directory_page.dart';
import 'package:orbital_nus/Orders/orders_page.dart';
import 'package:orbital_nus/Profile/profile_screen.dart';
import 'package:orbital_nus/colors.dart';
import 'enum.dart';

/*
  Includes the bottom navigation bar into the app which allows users to navigate
  between the different pages available.
  makes use of the navigation bar function with icons in placed.
  Once clicked, users will be redirected to the respective page accordingly with
  the material page route function.
  Once clicked the icons will be highlighted in a certain color to show
  which page the users are currently on.
*/
class Bottombar extends StatelessWidget {
  const Bottombar({
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
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        //Home button on bottom navigation bar
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
        //Orders button on bottom navigation bar
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
        //Cart button on bottom navigation bar
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
        // Profile button on bottom navigation bar
        IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const profilescreen()));
          },
          icon: Icon(Icons.person_outline,
              color: MenuState.profile == selectMenu
                  ? kSecondaryColor
                  : Colors.grey,
              size: 30),
        ),
      ]),
    );
  }
}
