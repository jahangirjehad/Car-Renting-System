import 'package:flutter/material.dart';
import 'package:car_renting_system/hirecar.dart';
import 'package:car_renting_system/notifi.dart';
import 'package:car_renting_system/trip.dart';
import 'package:car_renting_system/profile.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final _pages = [HireCar(), Notifiy(), Trip(), Profile()];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent[400],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Rent a Car and Drive Happy",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          //textAlign: TextAlign.center,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        unselectedItemColor: Colors.black,
        currentIndex: _currentIndex,
        selectedLabelStyle:
            TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Hire Car'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notification'),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Trip',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Person',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            print(_currentIndex);
          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}
