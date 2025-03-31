import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateUserData(String uid, Map<String, dynamic> data) async {
    await _firestore.collection('users').doc(uid).set(data, SetOptions(merge: true));
  }

  // Add methods for medication schedules, emergency contacts, etc., as needed
}