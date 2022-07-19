// page for new merchants to register for a merchant account (to be completed)

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orbital_nus/authentication/auth_page.dart';
import 'package:orbital_nus/colors.dart';

class MerchantRegisterPage extends StatefulWidget {
  const MerchantRegisterPage({Key? key}) : super(key: key);

  get showLoginPage => null;

  @override
  State<MerchantRegisterPage> createState() => _MerchantRegisterPageState();
}

class _MerchantRegisterPageState extends State<MerchantRegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // List and variable to store location of restaurant
  List<String> locations = [
    'Fine Food',
    'Flavours @ UTown',
    'Frontier',
    'TechnoEdge',
    'The Deck',
    'YIH'
  ];
  String? selectedLocation;

  // function which stores the messages to be displayed
  String alertMessage(int regCode) {
    // error messages
    switch (regCode) {
      case 1:
        return 'Error: Passwords do not match';
      case 2:
        return 'Error: Not all fields entered';
    }
    // message if registration is alright
    return 'Registration request sent, pending approval from administrator';
  }

  // function to check if all the details have been filled up
  // returns true if all filled up, false if otherwise
  bool isAllFilledIn() {
    if (_nameController.text == '' ||
        _emailController.text == '' ||
        _passwordController.text == '' ||
        _confirmPasswordController.text == '' ||
        selectedLocation == null) {
      return false;
    }
    return true;
  }

  // function to create a new account for the user to be added onto the database
  Future merchantSignUp() async {
    int regCode = 0;
    if (!passwordConfirmed()) {
      // ensures that 2 password fields matches
      regCode = 1;
    } else if (!isAllFilledIn()) {
      // ensures all the fields are entered
      regCode = 2;
    } else {
      // check if user account can be created
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());

        // add user details into the database
        addMerchantDetails(
            _nameController.text.trim(), _emailController.text.trim());
      } on FirebaseAuthException catch (e) {
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text('Error: ${e.code}'),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Close')),
              ],
            );
          },
        );
        return;
      }
    }
    // Alert message
    showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(alertMessage(regCode)),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  if (regCode == 0) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AuthPage()));
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Close'),
              ),
            ],
          );
        });
  }

  Future addMerchantDetails(String name, String email) async {
    // add onto restaurants database
    final getRestaurantId =
        FirebaseFirestore.instance.collection('restaurants').doc();
    // store restaurantId as a string to be used
    String restaurantId = '';
    await getRestaurantId.get().then((restaurant) {
      restaurantId = restaurant.reference.id;
    });

    // set relevant information for buyer
    await getRestaurantId.set({
      'merchantId': restaurantId,
      'merchantName': name,
      'place': selectedLocation,
      'isOpenForOrder': false,
      'adminApproval': 'Pending',
    });

    // add onto user database
    await FirebaseFirestore.instance.collection('users').doc(email).set({
      'name': name,
      'id': restaurantId,
      'userType': 'Merchant',
    });
  }

  // function to check if password and confirm password matches
  bool passwordConfirmed() {
    return (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        title: const Text('Merchant Registration'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // pickup@NUS logo
                Image.asset(
                  'assets/images/Logo.png',
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 10),

                // Instructions text
                Text(
                  'Fill in the following details to register!',
                  style: GoogleFonts.robotoCondensed(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 25),

                // Name text box
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Store Name',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Location dropdown menu
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: DropdownButtonFormField(
                    dropdownColor: Colors.white,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    hint: const Text('Store Location'),
                    value: selectedLocation,
                    items: locations
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                              ),
                            ))
                        .toList(),
                    onChanged: (item) =>
                        setState(() => selectedLocation = item as String?),
                  ),
                ),
                const SizedBox(height: 10),

                // Email text box
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Password text box
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Confirm Password text box
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Confirm Password',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Sign Up button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: merchantSignUp,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Center(
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
