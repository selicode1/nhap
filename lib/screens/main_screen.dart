import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:nhap/core/constants/app_colors.dart';
import 'package:nhap/screens/dashboard_screen.dart';
import 'package:nhap/screens/doctors_screen.dart';
import 'package:nhap/screens/hospitals_screen.dart';
import 'package:nhap/screens/view_records_screen.dart';

class MainScreen extends StatefulWidget {
  final int pageIndex; // ✅ define this property

  const MainScreen({super.key, required this.pageIndex});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;

  final List<Widget> _screens = [
    DashboardScreen(),
    HospitalsScreen(),
    DoctorsScreen(),
    PatientRecordsScreen()
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.pageIndex; // ✅ initialize from widget
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        backgroundColor: Colors.transparent,
        color: AppColors.primary,
        buttonBackgroundColor: AppColors.primary,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        height: 60,
        items: <Widget>[
          Icon(Icons.dashboard, size: 30, color: Colors.white),
          Icon(Icons.local_hospital, size: 30, color: Colors.white),
          Icon(Icons.people, size: 30, color: Colors.white),
          Icon(Icons.folder, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index; // ✅ update state properly
          });
        },
      ),
    );
  }
}
