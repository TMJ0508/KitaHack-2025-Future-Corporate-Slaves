import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CaretakerDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String caretakerId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(title: Text('Caretaker Dashboard')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('caretakers', arrayContains: caretakerId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          var elderlyUsers = snapshot.data!.docs;
          return ListView.builder(
            itemCount: elderlyUsers.length,
            itemBuilder: (context, index) {
              var user = elderlyUsers[index];
              return ListTile(
                title: Text(user['name'], style: TextStyle(fontSize: 20)),
                subtitle: Text('Last active: ${user['lastActive'] ?? 'Unknown'}'),
                onTap: () {
                  // Navigate to detailed view (e.g., medication schedule or status)
                },
              );
            },
          );
        },
      ),
    );
  }
}