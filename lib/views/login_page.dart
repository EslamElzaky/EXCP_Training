import 'package:excp_training/constant.dart';
import 'package:excp_training/helper/custom_button.dart';
import 'package:excp_training/helper/custom_text_field.dart';
import 'package:excp_training/views/home_view.dart';
import 'package:excp_training/views/regester_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static String id = 'login_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimarycolor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CostumFormTextField(
                hintText: 'email',
                obscureText: false,
              ),
              SizedBox(
                height: 20,
              ),
              CostumFormTextField(
                hintText: 'password',
                obscureText: true,
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                size: double.infinity,
                text: 'Login',
                onTap: () {
                  Navigator.pushNamed(context, 'BottomNavigation');
                  // naHandle login action
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?',
                        style: TextStyle(color: Colors.white)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegesterPage.id);
                      },
                      child: Text(
                        ' Register',
                        style: TextStyle(color: Color(0xffC7EDE6)),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
