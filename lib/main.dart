import 'package:fitness_app/pages/LoginSignupPage.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash/animated_splash.dart';

void main() => runApp(FitnessApp());

Function duringSplash = () {
  return 1;
};

Map<int, Widget> op = {1: Home()};

class FitnessApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplash(
        imagePath: 'assets/splashScreen.gif',
        home: Home(),
        customFunction: duringSplash,
        duration: 2500,
        type: AnimatedSplashType.BackgroundProcess,
        outputAndHome: op,
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: LoginSignupPage(),
      ),
    );
  }
}
