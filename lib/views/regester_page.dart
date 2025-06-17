import 'package:excp_training/helper/custom_text_field.dart';
import 'package:flutter/material.dart';

class RegesterPage extends StatelessWidget {
  const RegesterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2B475E),
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
              hintText: 'first name',
              obscureText: false,
            ),
            SizedBox(height: 20),
            CostumFormTextField(
              hintText: 'Mid name',
              obscureText: false,
            ),
            SizedBox(height: 20),
            CostumFormTextField(
              hintText: 'last name',
              obscureText: false,
            ),
            SizedBox(height: 20),
            CostumFormTextField(
              hintText: 'email',
              obscureText: false,
            ),
            SizedBox(height: 20),
            CostumFormTextField(
              
              hintText: 'password',
              obscureText: true,
            ),
            SizedBox(height: 20),
            CostumFormTextField(
              hintText: 'confirm password',
              obscureText: true,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
