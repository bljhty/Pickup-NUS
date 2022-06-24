import 'package:flutter/material.dart';

import '../Components/Bottom_bar.dart';
import '../Components/enum.dart';

class pastorders extends StatefulWidget {
  const pastorders({Key? key}) : super(key: key);

  @override
  State<pastorders> createState() => _pastordersState();
}

class _pastordersState extends State<pastorders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF003D7C),
        centerTitle: true,
        title: const Text('Past orders'),
      ),
    );
  }
}
