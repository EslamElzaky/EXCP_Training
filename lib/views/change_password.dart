import 'package:excp_training/constant.dart';
import 'package:excp_training/helper/custom_button.dart';
import 'package:excp_training/helper/custom_snack_bar.dart';
import 'package:excp_training/helper/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'profile_page.dart';

class ChangePasswordPage extends StatefulWidget {
  static String id = 'changePassword';

  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  String? oldPassword, newPassword, confirmPassword;
  bool isLoading = false;
  GlobalKey<FormState> formkey = GlobalKey();

  Future<void> changePassword() async {
    if (!formkey.currentState!.validate()) {
      // الفورم فيه أخطاء
      return;
    }
    if (oldPassword == null || newPassword == null || confirmPassword == null) {
      showSnackBar(context, 'Please fill all fields');
      return;
    }

    if (newPassword != confirmPassword) {
      showSnackBar(context, 'Passwords do not match');

      return;
    }

    setState(() => isLoading = true);

    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email;

    if (email == null) {
      showSnackBar(context, 'No user logged in');

      setState(() => isLoading = false);
      return;
    }

    try {
      final credential = EmailAuthProvider.credential(
        email: email,
        password: oldPassword!,
      );
      await user!.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword!);

      if (!mounted) return;
      showSnackBar(context, 'Password updated successfully');

      Navigator.pushReplacementNamed(context, ProfilePage.id);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        showSnackBar(context, 'Old password is incorrect');
      } else {
        showSnackBar(context, 'Error: ${e.message}');
      }
    } catch (e) {
      showSnackBar(context, 'Something went wrong');
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimarycolor,
      appBar: AppBar(
        title: Text('Change Password'),
        backgroundColor: Colors.white.withValues(alpha: 0.1),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CostumFormTextField(
                      onChanged: (data) {
                        oldPassword = data;
                      },
                      usePassword: true,
                      obscureText: true,
                      labelText: 'Old Password',
                      hintText: 'Enter old password',
                    ),
                    SizedBox(height: 16),
                    CostumFormTextField(
                      onChanged: (data) {
                        newPassword = data;
                      },
                      usePassword: true,
                      obscureText: true,
                      labelText: 'New Password',
                      hintText: 'Enter new password',
                    ),
                    SizedBox(height: 16),
                    CostumFormTextField(
                      onChanged: (data) {
                        confirmPassword = data;
                      },
                      usePassword: true,
                      obscureText: true,
                      labelText: 'Confirm New Password',
                      hintText: 'Confirm new password',
                    ),
                    SizedBox(height: 32),
                    CustomButton(
                      size: double.infinity,
                      text: 'change Password',
                      onTap: () {
                        changePassword();
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
