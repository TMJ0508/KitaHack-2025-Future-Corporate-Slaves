import 'package:flutter/material.dart';

class MedicationScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Medication Schedule')),
      body: Center(
        child: Text('Your medication schedule will appear here.', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}