/// Page after administrator logs in successfully
/// Allows administrators to approve/reject newly registered merchants

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_nus/Admin%20Side/Admin%20Home%20Page/models/approval_list_view.dart';
import 'package:orbital_nus/authentication/main_page.dart';
import 'package:orbital_nus/colors.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  PageController pageController = PageController();

  // Placeholders to store information
  List<String> restaurantIds = [];

  /// Obtains from database the list of pending merchants waiting for approval
  /// and updates it into restaurantIds variable
  Future getPendingMerchants() async {
    await FirebaseFirestore.instance
        .collection('restaurants')
        .where('adminApproval', isEqualTo: 'Pending')
        .get()
        .then((snapshot) => snapshot.docs.forEach((restaurantId) {
              restaurantIds.add(restaurantId.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: const Text(
          'Pending Merchants',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          // Logout Button
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const MainPage();
              }));
            },
            icon: const Icon(
              Icons.logout_outlined,
            ),
            alignment: Alignment.center,
          )
        ],
      ),
      body: FutureBuilder(
        future: getPendingMerchants(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: ApprovalListView(pageController, restaurantIds))
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
