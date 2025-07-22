import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excp_training/constant.dart';
import 'package:excp_training/helper/Custom_dropdown_field.dart';
import 'package:excp_training/helper/custom_button.dart';
import 'package:excp_training/helper/custom_snack_bar.dart';
import 'package:excp_training/helper/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  String? selectedCity;
  List<String> cities = [
    'Cairo',
    'Mansoura',
    'Alexandria',
    'Giza',
    'Aswan',
    'Luxor',
  ];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCurrentUserData();
  }

  Future<void> fetchCurrentUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();
      if (doc.exists) {
        final data = doc.data();
        firstNameController.text = data?['firstName'] ?? '';
        midNameController.text = data?['midName'] ?? '';
        lastNameController.text = data?['lastName'] ?? '';
        emailController.text = data?['email'] ?? '';
        phoneController.text = data?['phone'] ?? '';
        selectedCity = data?['city'];
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
        'city': selectedCity,
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update(updatedData);

      if (phoneController.text.length != 11) {
        showSnackBar(context, 'Phone number must be 11 digits');
        return;
      }

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
                      const SizedBox(height: 20),
                      CostumFormTextField(
                        keyboardType: TextInputType.phone,
                        hintText: 'Phone',
                        controller: phoneController,
                        maxLength: 11,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(11),
                        ],
                      ),
                      const SizedBox(height: 20),
                      CustomDropdownField(
                        items: cities,
                        labelText: 'Select City',
                        value: selectedCity,
                        onChanged: (data) {
                          setState(() {
                            selectedCity = data;
                          });
                        },
                        validator: (data) {
                          if (data == null || data.isEmpty) {
                            return 'Please select a city';
                          }
                          return null;
                        },
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
