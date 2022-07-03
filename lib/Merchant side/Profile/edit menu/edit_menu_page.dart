// Page to edit the foods on the menu of the restaurant

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_nus/Merchant%20side/Profile/edit%20menu/add_item_page.dart';
import 'package:orbital_nus/Merchant%20side/Profile/edit%20menu/models/menu_type_list.dart';
import 'package:orbital_nus/Buyer%20Side/get_information/get_food.dart';
import 'package:orbital_nus/Buyer%20Side/get_information/get_username.dart';
import 'package:orbital_nus/Merchant%20side/Profile/edit%20menu/models/item_list_view.dart';
import 'package:orbital_nus/colors.dart';

class EditMenuPage extends StatefulWidget {
  const EditMenuPage({Key? key}) : super(key: key);

  @override
  State<EditMenuPage> createState() => _EditMenuPageState();
}

class _EditMenuPageState extends State<EditMenuPage> {
  var selected = 0;
  final pageController = PageController();

  // Obtaining the relevant food item data tagged to the merchant Id from database
  // List of foods available for the specific restaurant
  List<Food> foods = [];

  // List of foods ordered based on menuType
  Map<String, List<Food>> foodsByType = {};

  // obtain database of foods for the merchant's menu
  getFoods() async {
    // obtain merchantId from user's info
    final user = FirebaseAuth.instance.currentUser!;
    Username userInfo = Username();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        .get()
        .then((value) {
      userInfo = Username.fromMap(value.data());
    });

    // obtain menu of food from logged in merchant
    await FirebaseFirestore.instance
        .collection('foods')
        .where('merchantId', isEqualTo: userInfo.id)
        .get()
        .then((snapshot) => snapshot.docs.forEach((food) {
              // for each item, to form it into class Food and add into list foods
              foods.add(Food.fromMap(food.data()));
            }));

    // delete the duplicate food in list foods

    // sort the foods into foods into foodsByType based on the item's menuType
    foods.forEach((food) {
      if (foodsByType[food.menuType!] == null) {
        foodsByType[food.menuType!] = [];
      }
      // add current food into the list of the menuType
      addFood(food);
    });
  }

  // function to check if food is a duplicate, if it isn't add onto the list
  addFood(Food food) {
    for (int i = 0; i < foodsByType[food.menuType!]!.length; i++) {
      if (food.itemId == foodsByType[food.menuType!]![i].itemId) {
        return;
      }
    }
    // checked through the list and no duplicates, add onto the list
    foodsByType[food.menuType!]?.add(food);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Edit Menu',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: getFoods(), // wait to compile foodsByType
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bar showing menuType i.e. Mains, Sides, etc.
                // uses menu_type_list.dart as widget
                MenuTypeList(selected, (int index) {
                  setState(() {
                    selected = index;
                  });
                  pageController.jumpToPage(index);
                }, foodsByType.keys.toList()),

                // List of available food in the page to edit
                // uses item_list_view.dart as widget
                Expanded(
                  child: ItemListView(selected, (int index) {
                    setState(() {
                      selected = index;
                    });
                  }, pageController, foodsByType.keys.toList(), foodsByType),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: SizedBox(
        width: 200,
        height: 56,
        child: RawMaterialButton(
          fillColor: kSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.add_outlined,
                color: Colors.white,
                size: 30,
              ),
              Text(
                'Add Food',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
            ],
          ),
          // Add a new food item to the menu
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddItemPage()));
          },
        ),
      ),
    );
  }
}
