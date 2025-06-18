import 'package:excp_training/constant.dart';
import 'package:excp_training/helper/custom_button.dart';
import 'package:excp_training/helper/custom_text_field.dart';
import 'package:excp_training/views/home_view.dart';
import 'package:excp_training/views/login_page.dart';
import 'package:flutter/material.dart';

class RegesterPage extends StatelessWidget {
  const RegesterPage({super.key});
  static String id = 'regesterpage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimarycolor,
      body: Center(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          children: [
            SizedBox(height: 50),
            Center(
              child: Text('REGISTER PAGE',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 20),
            CostumFormTextField(
              labelText: 'First name',
              hintText: 'first name',
              obscureText: false,
            ),
            SizedBox(height: 20),
            CostumFormTextField(
              labelText: 'Mid Name',
              hintText: 'Mid name',
              obscureText: false,
            ),
            SizedBox(height: 20),
            CostumFormTextField(
              labelText: 'Last Name',
              hintText: 'last name',
              obscureText: false,
            ),
            SizedBox(height: 20),
            CostumFormTextField(
              labelText: 'Email',
              hintText: 'email',
              obscureText: false,
            ),
            SizedBox(height: 20),
            CostumFormTextField(
              labelText: 'password',
              hintText: 'password',
              obscureText: true,
            ),
            SizedBox(height: 20),
            CostumFormTextField(
              labelText: 'confirm password',
              hintText: 'confirm password',
              obscureText: true,
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 20,
            ),
            CustomButton(
              size: double.infinity,
              text: 'Register',
              onTap: () {
                Navigator.pushNamed(context, HomeView.id);
                // naHandle login action
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Alrady have an account?',
                    style: TextStyle(color: Colors.white)),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, LoginPage.id);
                  },
                  child: Text(
                    ' Login',
                    style: TextStyle(color: Color(0xffC7EDE6)),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
