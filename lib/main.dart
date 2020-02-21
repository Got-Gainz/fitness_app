import 'package:fitness_app/pages/LoginSignupPage.dart';
import 'package:flutter/material.dart';

void main() => runApp(FitnessApp());

class FitnessApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: LoginSignupPage(),
      ),
    );
  }
}
