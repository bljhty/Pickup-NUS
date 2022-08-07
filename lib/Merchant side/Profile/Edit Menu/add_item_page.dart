/// Page to add food item onto the menu of the logged in restaurant
/// includes food item name, menu type, estimated waiting time and price
/// Once text boxes all filled up and 'Add Item' button is pressed, database
/// would add item into restaurant's menu

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orbital_nus/Buyer%20Side/Food%20Selection/Food%20Details/Models/food_detail_image.dart';
import 'package:orbital_nus/Merchant%20side/Profile/edit%20menu/edit_menu_page.dart';
import 'package:orbital_nus/colors.dart';
import 'package:orbital_nus/get_information/get_food.dart';
import 'package:orbital_nus/get_information/get_username.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({Key? key}) : super(key: key);

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  // Text controllers
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

  /// Obtains information from database regarding logged in merchant
  /// and updates userInfo variable
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

  /// Adds food item and its information into the database
  /// Once added successfully, success popup message appears and merchant is
  /// redirected back to edit menu page
  ///
  /// If not all text boxes is filled up, error popup message appears
  Future addItem() async {
    // Check if all the details are filled up
    if (!isAllFilled()) {
      // Provide popup message to ask to fill everything up
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: const Text('Please fill in all the details'),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Close'))
              ],
            );
          });
      return;
    }
    // Obtain newly generated foodId
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

    // Update the item info into the database
    await getFoodId.set(newFood.toMap());

    // Obtain foodId and store into the database
    String foodId = '';
    await getFoodId.get().then((food) {
      foodId = food.reference.id;
    });
    await getFoodId.update({
      'itemId': foodId,
    });

    // Provide popup message to say that item has been added
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

  /// Checks if all the text boxes have been filled up
  ///
  /// @return true if all filled up, else returns false
  bool isAllFilled() {
    if (_nameController.text == '' ||
        _priceController.text == '' ||
        _waitTimeController.text == '' ||
        _menuTypeController.text == '') {
      return false;
    }
    return true;
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
                  // Image of the food item
                  // Uses food_detail_image.dart
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
                    decoration:
                        const InputDecoration(labelText: 'Item Price: (\$)'),
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
