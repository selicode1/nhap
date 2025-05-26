import 'package:flutter/material.dart';
import 'package:nhap/screens/hospital_form_screen.dart';
import 'package:nhap/screens/hospitals_screen.dart';
import 'package:nhap/screens/login_screen.dart';
import 'package:nhap/screens/main_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    // home: MainScreen(pageIndex: 0),
    home: AddHospitalScreen(),
    );
  }
}
