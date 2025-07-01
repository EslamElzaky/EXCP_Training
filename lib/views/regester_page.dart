import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excp_training/constant.dart';
import 'package:excp_training/helper/custom_button.dart';
import 'package:excp_training/helper/custom_snack_bar.dart';
import 'package:excp_training/helper/custom_text_field.dart';
import 'package:excp_training/views/home_view.dart';
import 'package:excp_training/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegesterPage extends StatefulWidget {
  RegesterPage({super.key});
  static String id = 'regesterpage';

  @override
  State<RegesterPage> createState() => _RegesterPageState();
}

class _RegesterPageState extends State<RegesterPage> {
  String? email,
      phone,
      city,
      password,
      firstName,
      midName,
      lastName,
      confirmPassword;
  bool isLoading = false;

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
                child: Text('REGISTER PAGE',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
              CostumFormTextField(
                onChanged: (data) {
                  city = data;
                },
                labelText: 'City',
                hintText: 'city',
                
              ),
              SizedBox(height: 20),
              CostumFormTextField(
                keyboardType: TextInputType.phone,
                onChanged: (data) {
                  phone = data;
                },
                labelText: 'Phone',
                hintText: 'phone',
                
              ),
              SizedBox(height: 20),
              CostumFormTextField(
                onChanged: (data) {
                  email = data;
                },
                labelText: 'Email',
                hintText: 'email',
                
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
              SizedBox(
                height: 20,
              ),
              CustomButton(
                size: double.infinity,
                text: 'Register',
                onTap: () async {
                  if (formkey.currentState!.validate()) {
                    if (email == null ||
                        password == null ||
                        confirmPassword == null) {
                      showSnackBar(
                          context, 'Please fill in all required fields');
                      return;
                    }

                    // تحقق من تطابق كلمة المرور
                    if (password != confirmPassword) {
                      showSnackBar(context, 'Passwords do not match');
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
                        showSnackBar(
                          context,
                          'email-already-in-use',
                        );
                      }
                    } catch (e) {
                      showSnackBar(context, 'there was an error');
                      print(e);
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
                  Text('Alrady have an account?',
                      style: TextStyle(color: Colors.white)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context, LoginPage.id);
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
      ),
    );
  }

  Future<void> regeistermethod() async {
    // if (password != confirmPassword) {
    //   showSnackBar(context, 'password not match');
    //   return;
    // }
    // if (email == null || password == null) {
    //   throw Exception('Email and password are required');
    // }

    var auth = FirebaseAuth.instance;
    var firestore = FirebaseFirestore.instance;
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
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
