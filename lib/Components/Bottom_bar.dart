import 'package:flutter/material.dart';
import 'package:orbital_nus/Order/cart_page.dart';
import 'package:orbital_nus/Order/restaurant_directory_page.dart';
import 'package:orbital_nus/Profile/profile_screen.dart';
import 'package:orbital_nus/authentication/pages/orders_page.dart';

import 'enum.dart';

class Bottombar extends StatelessWidget {
  const Bottombar({
    Key? key,
    required this.selectMenu,
  }) : super(key: key);
  final MenuState selectMenu;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
        //Homebutton on bottom navigation bar
        IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RestaurantDirectoryPage()));
          },
          icon: Icon(Icons.home_outlined,
              color: MenuState.home == selectMenu
                  ? Color(0xff09b44d)
                  : Colors.grey,
              size: 30),
        ),
        //Orders button on bottom navigation bar
        IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const orderspage()));
          },
          icon: Icon(Icons.receipt_long_outlined,
              color: MenuState.orders == selectMenu
                  ? Color(0xff09b44d)
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
                  ? Color(0xff09b44d)
                  : Colors.grey,
              size: 30),
        ),
        //Profile button on bottom navigation bar
        IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const profilescreen()));
          },
          icon: Icon(Icons.person_outline,
              color: MenuState.profile == selectMenu
                  ? Color(0xff09b44d)
                  : Colors.grey,
              size: 30),
        ),
      ]),
    );
  }
}
