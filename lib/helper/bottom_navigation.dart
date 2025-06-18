import 'package:excp_training/views/home_view.dart';
import 'package:excp_training/views/profile_page.dart';
import 'package:excp_training/views/regester_page.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  static String id = 'BottomNavigation';

  const BottomNavigation({super.key});
  @override
  BottomNavigationState createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;

  final List<Widget> screens = [
    HomeView(),
    ProfilePage(),
    RegesterPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueGrey,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Notes',
          ),
        ],
      ),
    );
  }
}
