import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String role; // 'elderly' or 'caretaker'
  final String name;
  final List<String> caretakers;

  UserModel({required this.uid, required this.role, required this.name, this.caretakers = const []});

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      role: data['role'] ?? '',
      name: data['name'] ?? '',
      caretakers: List<String>.from(data['caretakers'] ?? []),
    );
  }
}