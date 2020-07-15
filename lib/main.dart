import 'package:flutter/material.dart';
import 'screens/welcome/welcome_screen.dart';

void main() {
  runApp(SelendraApp());
}

class SelendraApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WelcomeScreen(),
    );
  }
}


