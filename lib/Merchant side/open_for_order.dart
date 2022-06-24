// Widget to open/close the merchant for incoming orders
// shown in merchant_home_page.dart

import 'package:flutter/material.dart';
import 'package:orbital_nus/Merchant%20side/Merchant%20Bottom%20Bar/merchant_bottom_bar.dart';
import 'package:orbital_nus/colors.dart';

class OpenForOrder extends StatefulWidget {
  const OpenForOrder({Key? key}) : super(key: key);

  @override
  State<OpenForOrder> createState() => _OpenForOrderState();
}

class _OpenForOrderState extends State<OpenForOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Open/Close Restaurant'),
      ),
      bottomNavigationBar: const MerchantBottomBar(selectMenu: MenuState.open),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              // Open for Order
              Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: () {}, // to open up stall for orders
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const  Center(
                      child: Text(
                          'Open',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15,)
            ],
          ),
        ),
      ),
    );
  }
}
