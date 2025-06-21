
import 'package:excp_training/constant.dart';
import 'package:excp_training/helper/custom_button.dart';
import 'package:excp_training/helper/custom_text_field.dart';
import 'package:flutter/material.dart';

class EidtProfilePage extends StatelessWidget {
  const EidtProfilePage({super.key});
  static String id = 'edit_profile_page';
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
                hintText: 'first name',
                obscureText: false,
              ),
              SizedBox(
                height: 20,
              ),
              CostumFormTextField(
                hintText: 'mid name',
                obscureText: true,
              ),
                SizedBox(
                height: 20,
              ),
              CostumFormTextField(
                hintText: 'last name',
                obscureText: true,
              ),  SizedBox(
                height: 20,
              ),
              CostumFormTextField(
                hintText: 'phone',
                obscureText: true,
              ),  SizedBox(
                height: 20,
              ),
              CostumFormTextField(
                hintText: 'city',
                obscureText: false,
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                size: double.infinity,
                text: 'save',
                onTap: () {
                  Navigator.pushNamed(context, 'BottomNavigation');
                  // naHandle login action
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
