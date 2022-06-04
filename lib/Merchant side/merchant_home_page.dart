import 'package:flutter/material.dart';

class MerchantHomePage extends StatefulWidget {
  const MerchantHomePage({Key? key}) : super(key: key);

  @override
  State<MerchantHomePage> createState() => _MerchantHomePageState();
}

class _MerchantHomePageState extends State<MerchantHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          // top header to welcome user (need to change to actual merchant name)
          Text(
              'Welcome back USER!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32
            ),
          ),

          // button to start and stop orders
          // OpenForOrder()
        ],
      ),
    );
  }
}
