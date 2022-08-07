/// Widget presenting a scrolling list of information from ApprovalBox
/// Below each restaurant box contains approve and reject buttons
/// displayed in admin_home_page.dart
///
/// @param pageController page controller from the page
/// @param restaurantIds list of Ids of restaurants pending approval
/// @return a scrolling widget containing boxes with buttons to approve/reject
/// pending restaurants

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

  /// Updates database to approve restaurant's account
  /// updates restaurant's adminApproval to 'Approved'
  ///
  /// @param restaurantId Id of restaurant being approved
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

  /// Function provides popup dialog,
  /// for administrator to indicate reason for rejecting restaurant's account
  /// When submitted, calls function rejectRestaurant to reject the restaurant
  ///
  /// @param restaurantId Id of restaurant being rejected
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

  /// Updates database to reject restaurant's account
  /// updates restaurant's adminApproval to reason for rejecting account,
  /// which prevents the restaurant's account from being accessed
  ///
  /// @param restaurantId Id of restaurant being rejected
  /// @param reason Information on why restaurant is being rejected
  Future rejectRestaurant(String restaurantId, String reason) async {
    await FirebaseFirestore.instance
        .collection('restaurants')
        .doc(restaurantId)
        .update({'adminApproval': reason});

    // removes restaurantId from the list
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
