// Page for merchants to edit the information of the food item

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orbital_nus/Buyer%20Side/Order%20pages/food%20details/models/food_detail_image.dart';
import 'package:orbital_nus/Buyer%20Side/get_information/get_food.dart';
import 'package:orbital_nus/Buyer%20Side/get_information/get_username.dart';
import 'package:orbital_nus/Merchant%20side/Profile/edit%20menu/edit_menu_page.dart';
import 'package:orbital_nus/colors.dart';

class EditItemPage extends StatefulWidget {
  final Food food;

  EditItemPage(this.food);

  @override
  State<EditItemPage> createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
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

  // Function to save the updated item information into the database
  Future editItem() async {
    // update the item info into the database
    Food updatedFood = Food(
      merchantId: widget.food.merchantId,
      itemName: _nameController.text.trim(),
      itemId: widget.food.itemId,
      menuType: _menuTypeController.text.trim(),
      imgUrl: widget.food.imgUrl,
      waitTime: _waitTimeController.text.trim(),
      price: num.parse(_priceController.text.trim()),
    );

    await FirebaseFirestore.instance
        .collection('foods')
        .doc(widget.food.itemId)
        .update(updatedFood.toMap());

    // provide alert message to indicate item info has been edited successfully
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Edit Item'),
            content: const Text('Item has been edited!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const EditMenuPage()));
                },
                child: const Text('Close'),
              ),
            ],
          );
        });
  }

  Future deleteItemNotif() async {
    // provide popup message to confirm deleting order
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete Item'),
            content: const Text('Are you sure?'),
            actions: <Widget>[
              // confirm button
              TextButton(
                onPressed: () {
                  deleteItem();
                },
                child: const Text('Confirm'),
              ),
              // cancel button
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              )
            ],
          );
        });
  }

  // Function to delete the item from the menu and database
  Future deleteItem() async {
    await FirebaseFirestore.instance
        .collection('foods')
        .doc(widget.food.itemId)
        .delete()
        .then(
          (doc) => print('item deleted'),
          onError: (e) => print('error updating document $e'),
        );

    // return to the edit_menu_page
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const EditMenuPage(),
    ));
  }

  @override
  void initState() {
    super.initState();
    // input the current values of the item into the controllers
    _nameController.text = widget.food.itemName!;
    _menuTypeController.text = widget.food.menuType!;
    _waitTimeController.text = widget.food.waitTime!;
    _priceController.text = widget.food.price!.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: const Text(
          'Edit Item',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              deleteItemNotif();
            },
            icon: const Icon(
              Icons.delete_rounded,
            ),
            alignment: Alignment.center,
          ),
        ],
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
                  // TODO: be able to edit the photo
                  FoodImg(widget.food),
                  const SizedBox(height: 10),

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
                    decoration: const InputDecoration(labelText: 'Item Price:'),
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

      // update item button
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
            'Confirm Edit',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 21,
            ),
          ),
          onPressed: () {
            editItem();
          },
        ),
      ),
    );
  }
}
