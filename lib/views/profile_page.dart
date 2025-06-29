import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excp_training/constant.dart';
import 'package:excp_training/helper/custom_button.dart';
import 'package:excp_training/helper/custom_icons.dart';
import 'package:excp_training/helper/custom_text_field.dart';
import 'package:excp_training/views/change_password.dart';
import 'package:excp_training/views/eidt_profile_page.dart';
import 'package:excp_training/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static String id = 'ProfilePage';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc.exists) {
        final data = doc.data();nameController.text =
            "${data?['firstName'] ?? ''} ${data?['midName'] ?? ''} ${data?['lastName'] ?? ''}"
                .trim();
        emailController.text = data?['email'] ?? '';
        phoneController.text = data?['phone'] ?? '';
        cityController.text = data?['city'] ?? '';
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  void navigateToEditProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EidtProfilePage(),
      ),
    );
    if (result == true) {
      fetchUserData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimarycolor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white.withValues(alpha: 0.2),
        title: Row(
          children: [
            const Text(
              'My Profile',
              style: TextStyle(fontSize: 24),
            ),
            const Spacer(),
            CustomIcons(
              icon: const Icon(Icons.logout),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                if (!context.mounted) return;
                Navigator.pushReplacementNamed(context, LoginPage.id);
              },
            )
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    CostumFormTextField(
                      readOnly: true,
                      labelText: 'Name',
                      prefixText: 'MyName : ',
                      controller: nameController,
                      obscureText: false,
                    ),
                    const SizedBox(height: 20),
                    CostumFormTextField(
                      readOnly: true,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Email',
                      prefixText: 'Email : ',
                      controller: emailController,
                      obscureText: false,
                    ),
                    const SizedBox(height: 20),
                    CostumFormTextField(
                      readOnly: true,
                      keyboardType: TextInputType.phone,
                      hintText: 'Phone',
                      prefixText: 'MyPhone : ',
                      controller: phoneController,
                      obscureText: false,
                    ),
                    const SizedBox(height: 20),
                    CostumFormTextField(
                      readOnly: true,
                      prefixText: 'MyCountry : ',
                      hintText: 'City',
                      controller: cityController,
                      obscureText: false,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          size: 150,
                          color: const Color.fromARGB(255, 195, 204, 213),
                          text: 'Edit Data',
                          onTap: navigateToEditProfile,
                        ),
                        CustomButton(
                          color: const Color.fromARGB(255, 195, 204, 213),
                          size: 150,
                          text: 'Password',
                          onTap: () {
                            Navigator.pushNamed(context, ChangePasswordPage.id);
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
