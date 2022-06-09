import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetRestaurant extends StatelessWidget {
  final String documentId;

  GetRestaurant({required this.documentId});

  @override
  Widget build(BuildContext context) {
    // obtain the collection from Firebase database
    CollectionReference merchant = FirebaseFirestore.instance.collection(
        'merchant');
    return FutureBuilder<DocumentSnapshot>(
      future: merchant.doc(documentId).get(),
        builder: ((context, snapshot) {
      if (snapshot.connectionState ==
          ConnectionState.done) { // determines if snapshot is fully loaded
        Map<String, dynamic> data =
        snapshot.data!.data() as Map<String, dynamic>;
        return Text('Restaurant Name: ${data['merchantName']}');
      }
      return const Text('Loading...');
    }));
  }
}
