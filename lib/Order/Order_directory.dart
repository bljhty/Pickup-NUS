import 'package:flutter/material.dart';
import 'package:orbital_nus/screen/widgets/app_bar.dart';

class OrderDirectoryPage extends StatefulWidget {
  const OrderDirectoryPage({Key? key}) : super(key: key);

  @override
  State<OrderDirectoryPage> createState() => _OrderDirectoryPageState();
}

class _OrderDirectoryPageState extends State<OrderDirectoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAppBar(
            Icons.arrow_back_outlined,
            Icons.search_outlined,
          ),
        ],
      ),
    );
  }
}
