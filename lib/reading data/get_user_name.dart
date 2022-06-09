import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {
  final String userId;

  GetUserName({required this.userId});

  @override
  Widget build(BuildContext context) {

    // get the collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      builder: ((context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data = snapshot.data!.data() as Map<String,
            dynamic>;
        return Text('${data['name']}');
      }
      return const Text('Error');
    }),
    );
  }
}
