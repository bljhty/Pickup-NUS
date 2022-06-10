import 'package:flutter/material.dart';
import 'package:orbital_nus/Components/Bottom_bar.dart';
import 'package:orbital_nus/Components/enum.dart';

class orderspage extends StatelessWidget {
  const orderspage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        title: const Text(
          "My Orders",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: const Bottombar(
        selectMenu: MenuState.orders,
      ),
    );
  }
}
