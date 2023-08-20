import 'package:car_renting_system/ownerHome.dart';
import 'package:car_renting_system/ownerNotifi.dart';
import 'package:car_renting_system/ownerProfile.dart';
import 'package:flutter/material.dart';

class CarOwner extends StatefulWidget {
  const CarOwner({Key? key}) : super(key: key);

  @override
  State<CarOwner> createState() => _CarOwnerState();
}

class _CarOwnerState extends State<CarOwner> {
  final _pages = [OwnerHome(), OwnerNotifi(), OwnerProfile()];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFb1c4d2),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notification'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
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
