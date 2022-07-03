// Widget indicating the special instructions to be the merchant upon ordering

import 'package:flutter/material.dart';
import 'package:orbital_nus/get_information/get_order.dart';

class FoodAddOn extends StatefulWidget {
  final Order order;

  FoodAddOn(this.order);

  @override
  State<FoodAddOn> createState() => _FoodAddOnState();
}

class _FoodAddOnState extends State<FoodAddOn> {
  // text controller to retrieve value in text field
  final _instructionController = TextEditingController();

  @override
  initState() {
    super.initState();
    // listen for changes in text
    _instructionController.addListener(() {
      // store the instructions into order class
      widget.order.instructions = _instructionController.text.trim();
    });
  }

  @override
  void dispose() {
    // clean up the controller when the widget is disposed
    _instructionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // To include special instructions
          const Text(
            'Special Instructions: ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          const SizedBox(
            height: 20,
          ),

          TextField(
            controller: _instructionController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Special Instructions here',
            ),
          )
        ],
      ),
    );
  }
}
