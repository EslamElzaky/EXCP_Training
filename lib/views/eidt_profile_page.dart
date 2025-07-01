// // ✅ صفحة التعديل بعد التعديل الكامل:

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excp_training/constant.dart';
import 'package:excp_training/helper/custom_button.dart';
import 'package:excp_training/helper/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EidtProfilePage extends StatefulWidget {
  const EidtProfilePage({super.key});
  static String id = 'edit_profile_page';

  @override
  State<EidtProfilePage> createState() => _EidtProfilePageState();
}

class _EidtProfilePageState extends State<EidtProfilePage> {
  final firstNameController = TextEditingController();
  final midNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCurrentUserData();
  }

  Future<void> fetchCurrentUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc.exists) {
        final data = doc.data();
        firstNameController.text = data?['firstName'] ?? '';
        midNameController.text = data?['midName'] ?? '';
        lastNameController.text = data?['lastName'] ?? '';
        emailController.text = data?['email'] ?? '';
        phoneController.text = data?['phone'] ?? '';
        cityController.text = data?['city'] ?? '';
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> saveChanges() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      Map<String, dynamic> updatedData = {
        'firstName': firstNameController.text.trim(),
        'midName': midNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
        'city': cityController.text.trim(),
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update(updatedData);

      if (mounted) Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimarycolor,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      CostumFormTextField(
                        hintText: 'First Name',
                        controller: firstNameController,
                        obscureText: false,
                      ),
                      const SizedBox(height: 20),
                      CostumFormTextField(
                        hintText: 'Mid Name',
                        controller: midNameController,
                      ),
                      const SizedBox(height: 20),
                      CostumFormTextField(
                        hintText: 'Last Name',
                        controller: lastNameController,
                      ),
                      const SizedBox(height: 20),
                      CostumFormTextField(
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Email',
                        controller: emailController,
                      ),
                      const SizedBox(height: 20),
                      CostumFormTextField(
                        keyboardType: TextInputType.phone,
                        hintText: 'Phone',
                        controller: phoneController,
                      ),
                      const SizedBox(height: 20),
                      CostumFormTextField(
                        hintText: 'City',
                        controller: cityController,
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        size: double.infinity,
                        text: 'Save',
                        onTap: saveChanges,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
