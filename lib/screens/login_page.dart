import 'package:excp_training/helper/custom_button.dart';
import 'package:excp_training/helper/custom_text_field.dart';
import 'package:excp_training/screens/regester_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static String id = 'login_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2B475E),
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
                text: 'Login',
                onTap: () {
                  // Handle login action
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?',
                      style: TextStyle(color: Colors.white)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegesterPage(),
                          ));
                    },
                    child: Text(
                      ' Register',
                      style: TextStyle(color: Color(0xffC7EDE6)),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
