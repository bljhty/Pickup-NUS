// Page to add item onto the menu of the logged in buyer

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orbital_nus/Buyer%20Side/Order%20pages/food%20details/models/food_detail_image.dart';
import 'package:orbital_nus/Buyer%20Side/get_information/get_food.dart';
import 'package:orbital_nus/Buyer%20Side/get_information/get_username.dart';
import 'package:orbital_nus/Merchant%20side/Profile/edit%20menu/edit_menu_page.dart';
import 'package:orbital_nus/colors.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({Key? key}) : super(key: key);

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  // text controllers
  final _nameController = TextEditingController();
  final _menuTypeController = TextEditingController();
  final _waitTimeController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _menuTypeController.dispose();
    _waitTimeController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  // Placeholder to store user info
  Username userInfo = Username();

  // to obtain information about the user
  Future getUserInfo() async {
    final user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        .get()
        .then((value) {
      userInfo = Username.fromMap(value.data());
    });
  }

  // Function to add the item into the database
  Future addItem() async {
    // obtain newly generated foodId
    final getFoodId = FirebaseFirestore.instance.collection('foods').doc();

    // Food class to store information
    Food newFood = Food(
      merchantId: userInfo.id,
      itemName: _nameController.text.trim(),
      menuType: _menuTypeController.text.trim(),
      imgUrl: 'assets/images/Logo.png',
      waitTime: _waitTimeController.text.trim(),
      price: num.parse(_priceController.text.trim()),
    );

    // update the item info into the database
    await getFoodId.set(newFood.toMap());

    // obtain foodId and store into the database
    String foodId = '';
    await getFoodId.get().then((food) {
      foodId = food.reference.id;
    });
    await getFoodId.update({
      'itemId': foodId,
    });

    // provide popup message to say that item has been added
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text('Item Added to Menu!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const EditMenuPage(),
                  ));
                },
                child: const Text('Close'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: const Text(
          'Add Item',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder(
        future: getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // image of the food item
                  // uses food_detail_image.dart
                  // TODO: be able to upload own photo
                  FoodImg(Food(imgUrl: "assets/icons/logo_foreground.png")),
                  const SizedBox(
                    height: 10,
                  ),

                  // Item Name
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Item Name:'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // Menu Type
                  TextField(
                    controller: _menuTypeController,
                    decoration: const InputDecoration(labelText: 'Menu Type:'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // Item Waiting Time
                  TextField(
                    controller: _waitTimeController,
                    decoration:
                        const InputDecoration(labelText: 'Item Waiting Time:'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // Item Price
                  TextField(
                    controller: _priceController,
                    // to allow only numbers
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true, signed: false),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r"[0-9.]"))
                    ],
                    decoration: const InputDecoration(labelText: 'Item Price: (\$)'),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),

      // Add Item button
      floatingActionButton: SizedBox(
        width: 200,
        height: 56,
        child: RawMaterialButton(
          fillColor: kSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 2,
          child: const Text(
            'Add Item',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 21,
            ),
          ),
          onPressed: () {
            addItem();
          },
        ),
      ),
    );
  }
}
