import 'package:excp_training/firebase_options.dart';
import 'package:excp_training/helper/bottom_navigation.dart';
import 'package:excp_training/views/Categories_page.dart';
import 'package:excp_training/views/eidt_profile_page.dart';
import 'package:excp_training/views/home_view.dart';
import 'package:excp_training/views/login_page.dart';
import 'package:excp_training/views/profile_page.dart';
import 'package:excp_training/views/regester_page.dart';
import 'package:excp_training/views/change_password.dart';
import 'package:excp_training/views/task_eidt_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
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
        'edit_profile_page': (context) => EidtProfilePage(),
        'changePassword': (context) => ChangePasswordPage(),
        'task_edit_page': (context) => TaskEidtPage(),
        'categories_page': (context) => CategoriesPage(),
      },
      initialRoute: 'login_page',
    );
  }
}
