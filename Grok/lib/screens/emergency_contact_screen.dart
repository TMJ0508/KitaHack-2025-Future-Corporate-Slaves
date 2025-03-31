import 'package:flutter/material.dart';

class EmergencyContactsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Emergency Contacts')),
      body: Center(
        child: Text('Manage your emergency contacts here.', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}