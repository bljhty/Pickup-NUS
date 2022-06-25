// page for new users to register for an account

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_nus/authentication/Merchant/merchant_register_page.dart';
import 'package:orbital_nus/colors.dart';

/*
  register page for new users who do not have an account to create one
  and use the app.
  contains standard widgets for users to enter their required information that
  is used to create an account.
*/

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;

  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

/*
  email and password verification feature to ensure that a valid email is being
  entered and password used matches the password requirement before users are
  able to sign up for an account
*/
  // function which stores the messages to be displayed
  String alertMessage(int regCode) {
    // error messages
    switch (regCode) {
      case 1:
        return 'Error: Password is too weak, ensure it has at least 6 characters';
      case 2:
        return 'Error: The email provided already has an active account';
      case 3:
        return 'Error: Passwords do not match';
    }
    // message if registration is alright
    return 'Registration successful';
  }

  // function to create a new account for the user to be added onto the database
  Future userSignUp() async {
    // ensure that 2 password fields matches
    int regCode = 0;
    if (!passwordConfirmed()) {
      regCode = 3;
    } else {
      // check if user account can be created
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());

        // add user details into the database
        addBuyerDetails(
            _nameController.text.trim(), _emailController.text.trim());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          regCode = 1;
        } else if (e.code == 'email-already-in-use') {
          regCode = 2;
        }
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
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          );
        });
  }

  // Add information about the buyer into the database
  Future addBuyerDetails(String name, String email) async {
    // add onto buyer database
    final getBuyerId = FirebaseFirestore.instance.collection('buyer').doc();
    // store buyerId as a string to be used
    String buyerId = '';
    await getBuyerId.get().then((buyer) {
      buyerId = buyer.reference.id;
    });
    // set relevant information for buyer
    await getBuyerId.set({
      'buyerId': buyerId,
      'buyerName': name,
      'cart': [],
    });

    // add onto user database
    await FirebaseFirestore.instance.collection('users').doc(email).set({
      "name": name,
      "id": buyerId,
      "userType": "Buyer",
    });
  }

  // function to check if password and confirm password matches
  bool passwordConfirmed() {
    return (_passwordController.text.trim() ==
        _confirmpasswordController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: const Text('User Registration'),
          automaticallyImplyLeading: false,
        ),
        backgroundColor: kPrimaryColor,
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
                  const Text(
                    'Fill in the following details:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),

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
                            hintText: 'Name',
                          ),
                        ),
                      ),
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
                          controller: _confirmpasswordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Confirm Password',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Sign Up button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      onTap: userSignUp,
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
                  const SizedBox(height: 20),

                  // Sign In button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already a member?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.showLoginPage,
                        // directs user to a sign up page
                        child: const Text(
                          ' Sign In!',
                          style: TextStyle(
                            color: kSecondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // sign up as a Merchant
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) {
                      //     return const MerchantRegisterPage();
                      //   }),
                      // );
                    },
                    child: const Text(
                      'Sign up as a Merchant instead? (Coming soon)',
                      style: TextStyle(
                        color: kSecondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
