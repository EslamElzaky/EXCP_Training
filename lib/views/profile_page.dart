import 'package:excp_training/constant.dart';
import 'package:excp_training/helper/custom_button.dart';
import 'package:excp_training/helper/custom_icons.dart';
import 'package:excp_training/helper/custom_text_field.dart';
import 'package:excp_training/views/home_view.dart';
import 'package:excp_training/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  static String id = 'ProfilePage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimarycolor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white.withValues(alpha: .2),
        // backgroundColor: const Color.fromARGB(255, 83, 96, 106),
        title: Row(
          children: [
            Text('My Profile',
                style: TextStyle(
                  fontSize: 24,
                )),
            Spacer(),
            CustomIcons(
                icon: Icon(Icons.logout),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  if (!context.mounted) return;
                  // بعد تسجيل الخروج، الرجوع لصفحة تسجيل الدخول
                  Navigator.pushReplacementNamed(context, LoginPage.id);
                })
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              CostumFormTextField(
                hintText: 'name',
                obscureText: false,
              ),
              SizedBox(
                height: 20,
              ),
              CostumFormTextField(
                keyboardType: TextInputType.emailAddress,
                hintText: 'email',
                obscureText: true,
              ),
              SizedBox(
                height: 20,
              ),
              CostumFormTextField(
                keyboardType: TextInputType.phone,
                hintText: 'Phone',
                obscureText: true,
              ),
              SizedBox(
                height: 20,
              ),
              CostumFormTextField(
                hintText: 'City',
                obscureText: true,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    size: 150,
                    color: const Color.fromARGB(255, 195, 204, 213),
                    text: 'Eidt Data',
                    onTap: () {
                      // Handle login action
                    },
                  ),
                  CustomButton(
                    color: const Color.fromARGB(255, 195, 204, 213),
                    size: 150,
                    text: 'Password',
                    onTap: () {
                      // Handle login action
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
