import 'package:excp_training/helper/bottom_navigation.dart';
import 'package:excp_training/views/home_view.dart';
import 'package:excp_training/views/login_page.dart';
import 'package:excp_training/views/profile_page.dart';
import 'package:excp_training/views/regester_page.dart';
import 'package:flutter/material.dart';

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
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Poppins'),
      routes: {
        'login_page': (context) => LoginPage(),
        'BottomNavigation': (context) => BottomNavigation(),
        HomeView.id: (context) => HomeView(),
        'regesterpage': (context) => RegesterPage(),
        ProfilePage.id: (context) => ProfilePage(),
      },
      initialRoute: 'login_page',
    );
  }
}
