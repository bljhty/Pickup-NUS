// Widget indicating the special instructions to be the merchant upon ordering

import 'package:flutter/material.dart';

class FoodAddOn extends StatelessWidget {
  const FoodAddOn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          // To include special instructions
          Text(
              'Special Instructions: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22
            ),
          ),
          SizedBox(height: 20 ,),

          TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Special Instructions here',
            ),
          )
        ],
      ),
    );
  }
}
