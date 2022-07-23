// Lists out the restaurants that are pending approval for their accounts
// displayed in admin_home_page.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orbital_nus/Admin%20Side/Admin%20Home%20Page/models/approval_box.dart';
import 'package:orbital_nus/colors.dart';

class ApprovalListView extends StatefulWidget {
  final PageController pageController;
  final List<String> restaurantIds;

  ApprovalListView(
    this.pageController,
    this.restaurantIds,
  );

  @override
  State<ApprovalListView> createState() => _ApprovalListViewState();
}

class _ApprovalListViewState extends State<ApprovalListView> {
  // Text controller
  final _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  // Function to approve the restaurant's account
  Future approveRestaurant(String restaurantId) async {
    // change adminApproval to 'Approved'
    await FirebaseFirestore.instance
        .collection('restaurants')
        .doc(restaurantId)
        .update({'adminApproval': 'Approved'});
    // remove restaurantId from the list
    widget.restaurantIds.remove(restaurantId);
    setState(() {}); // to reload the page
  }

  // Function to input reasoning for rejecting a restaurant
  Future rejectRestaurantNotif(String restaurantId) async {
    // to request reason for rejection
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Reason for Rejecting'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Enter Reason'),
            controller: _reasonController,
          ),
          actions: [
            // Submit button
            TextButton(
              onPressed: () {
                // update adminApproval with reason of rejection
                rejectRestaurant(restaurantId, _reasonController.text.trim());
                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),

            // Cancel button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // function to reject restaurant's account
  Future rejectRestaurant(String restaurantId, String reason) async {
    await FirebaseFirestore.instance
        .collection('restaurants')
        .doc(restaurantId)
        .update({'adminApproval': reason});

    // remove restaurantId from the list
    widget.restaurantIds.remove(restaurantId);
    setState(() {}); // to reload the page
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.separated(
        controller: widget.pageController,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          return Column(
            children: [
              // box indicating the restaurant being approved/rejected
              GestureDetector(
                onTap: () {},
                child: ApprovalBox(widget.restaurantIds[index]),
              ),

              // button to approve restaurant
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: () {
                    approveRestaurant(widget.restaurantIds[index]);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Approve',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // button to reject restaurant
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: () {
                    rejectRestaurantNotif(widget.restaurantIds[index]);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Reject',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 12,
          );
        },
        itemCount: widget.restaurantIds.length,
      ),
    );
  }
}
