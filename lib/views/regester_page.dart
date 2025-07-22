import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excp_training/constant.dart';
import 'package:excp_training/helper/Custom_dropdown_field.dart';
import 'package:excp_training/helper/custom_button.dart';
import 'package:excp_training/helper/custom_snack_bar.dart';
import 'package:excp_training/helper/custom_text_field.dart';
import 'package:excp_training/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegesterPage extends StatefulWidget {
  const RegesterPage({super.key});
  static String id = 'regesterpage';

  @override
  State<RegesterPage> createState() => _RegesterPageState();
}

class _RegesterPageState extends State<RegesterPage> {
  final TextEditingController phoneController = TextEditingController();

  String? email,
      phone,
      city,
      password,
      firstName,
      midName,
      lastName,
      confirmPassword;
  bool isLoading = false;
  String? selectedCity;
  List<String> cities = [
    'Cairo',
    'Mansoura',
    'Alexandria',
    'Giza',
    'Aswan',
    'Luxor',
  ];
  GlobalKey<FormState> formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimarycolor,
        body: Form(
          key: formkey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            children: [
              SizedBox(height: 50),
              Center(
                child: Text(
                  'REGISTER PAGE',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              CostumFormTextField(
                onChanged: (data) {
                  firstName = data;
                },
                labelText: 'First name',
                hintText: 'first name',
              ),
              SizedBox(height: 20),
              CostumFormTextField(
                onChanged: (data) {
                  midName = data;
                },
                labelText: 'Mid Name',
                hintText: 'Mid name',
              ),
              SizedBox(height: 20),
              CostumFormTextField(
                onChanged: (data) {
                  lastName = data;
                },
                labelText: 'Last Name',
                hintText: 'last name',
              ),
              SizedBox(height: 20),
              CustomDropdownField(
                items: cities,
                labelText: 'Select City',
                value: selectedCity,
                onChanged: (data) {
                  city = data;
                },
                validator: (data) {
                  if (data == null || data.isEmpty) {
                    return 'Please select a city';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              CostumFormTextField(
                keyboardType: TextInputType.phone,
                onChanged: (data) {
                  phone = data;
                },
                labelText: 'Phone',
                hintText: 'phone',
                maxLength: 11,
                controller: phoneController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
              ),
              SizedBox(height: 20),
              CostumFormTextField(
                onChanged: (data) {
                  email = data;
                },
                labelText: 'Email',
                hintText: 'email',
                validator: (data) {
                  if (data == null || data.trim().isEmpty) {
                    return 'Email is required';
                  }

                  final emailRegex = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );
                  if (!emailRegex.hasMatch(data.trim())) {
                    return 'Please enter a valid email address';
                  }

                  return null;
                },
              ),
              SizedBox(height: 20),
              CostumFormTextField(
                onChanged: (data) {
                  password = data;
                },
                labelText: 'password',
                hintText: 'password',
                obscureText: true,
                usePassword: true,
              ),
              SizedBox(height: 20),
              CostumFormTextField(
                onChanged: (data) {
                  confirmPassword = data;
                },
                labelText: 'confirm password',
                hintText: 'confirm password',
                obscureText: true,
                usePassword: true,
              ),
              SizedBox(height: 20),
              SizedBox(height: 20),
              CustomButton(
                size: double.infinity,
                text: 'Register',
                onTap: () async {
                  if (formkey.currentState!.validate()) {
                    if (email == null ||
                        password == null ||
                        confirmPassword == null) {
                      showSnackBar(
                        context,
                        'Please fill in all required fields',
                      );
                      return;
                    }
                    if (phoneController.text.length != 11) {
                      showSnackBar(context, 'Phone number must be 11 numbers');
                      return;
                    }

                    // تحقق من تطابق كلمة المرور
                    if (password != confirmPassword) {
                      showSnackBar(context, 'Passwords do not match');
                      return;
                    }
                    if (city == null) {
                      showSnackBar(context, 'Please select a city');
                      return;
                    }

                    isLoading = true;
                    setState(() {});
                    try {
                      await regeistermethod();
                      if (!context.mounted) return;

                      Navigator.pushNamed(context, 'BottomNavigation');
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        showSnackBar(
                          context,
                          'The password provided is too weak.',
                        );
                      } else if (e.code == 'email-already-in-use') {
                        showSnackBar(context, 'email-already-in-use');
                      }
                    } catch (e) {
                      showSnackBar(context, 'there was an error');
                    }
                    isLoading = false;
                    setState(() {});
                  } else {}

                  // naHandle login action
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Alrady have an account?',
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context, LoginPage.id);
                    },
                    child: Text(
                      ' Login',
                      style: TextStyle(color: Color(0xffC7EDE6)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> regeistermethod() async {
    var auth = FirebaseAuth.instance;
    var firestore = FirebaseFirestore.instance;
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
    await firestore.collection('users').doc(userCredential.user?.uid).set({
      'uid': userCredential.user?.uid,
      'email': email,
      'firstName': firstName,
      'midName': midName,
      'lastName': lastName,
      'phone': phone,
      'city': city,
    });
  }
}
