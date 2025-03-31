import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'elderly_main_screen.dart';
import 'caretaker_dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  String email = '';
  String password = '';
  String error = '';

  Future<void> _login() async {
    final user = await _authService.signIn(email, password);
    if (user != null) {
      if (user.role == 'elderly') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ElderlyMainScreen()),
        );
      } else if (user.role == 'caretaker') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CaretakerDashboardScreen()),
        );
      }
    } else {
      setState(() => error = 'Login failed. Check your credentials.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => email = value,
              decoration: InputDecoration(labelText: 'Email'),
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              onChanged: (value) => password = value,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login', style: TextStyle(fontSize: 20)),
              style: ElevatedButton.styleFrom(minimumSize: Size(200, 50)),
            ),
            if (error.isNotEmpty) Text(error, style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}