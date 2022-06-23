// Box that lists information of the order
// being prepared based on the orderId

import 'package:flutter/material.dart';

class OrderReadyBox extends StatefulWidget {
  final String OrderId;

  OrderReadyBox(this.OrderId);

  @override
  State<OrderReadyBox> createState() => _OrderReadyBoxState();
}

class _OrderReadyBoxState extends State<OrderReadyBox> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
