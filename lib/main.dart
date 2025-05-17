import 'package:flutter/material.dart';
import 'package:nhap/screens/login_screen.dart';
import 'package:nhap/screens/main_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    // home: MainScreen(pageIndex: 0), // Start with the first screen
    home: LoginScreen(),
    );
  }
}
