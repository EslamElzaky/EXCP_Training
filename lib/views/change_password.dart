import 'package:excp_training/constant.dart';
import 'package:excp_training/helper/custom_button.dart';
import 'package:excp_training/helper/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'profile_page.dart'; // تأكد إنك مستورد الصفحة دي

class ChangePasswordPage extends StatefulWidget {
  static String id = 'changePassword';

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  String? oldPassword, newPassword, confirmPassword;
  bool isLoading = false;

  Future<void> changePassword() async {
    if (oldPassword == null || newPassword == null || confirmPassword == null) {
      _showMsg('Please fill all fields');
      return;
    }

    if (newPassword != confirmPassword) {
      _showMsg('Passwords do not match');
      return;
    }

    setState(() => isLoading = true);

    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email;

    if (email == null) {
      _showMsg('No user logged in');
      setState(() => isLoading = false);
      return;
    }

    try {
      final credential =
          EmailAuthProvider.credential(email: email, password: oldPassword!);
      await user!.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword!);

      if (!mounted) return;
      _showMsg('Password updated successfully');

      // ✅ الانتقال إلى صفحة البروفايل بعد التحديث
      Navigator.pushReplacementNamed(context, ProfilePage.id);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        _showMsg('Old password is incorrect');
      } else {
        _showMsg('Error: ${e.message}');
      }
    } catch (e) {
      _showMsg('Something went wrong');
    }

    setState(() => isLoading = false);
  }

  void _showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
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
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CostumFormTextField(
                    obscureText: true,
                    labelText: 'Old Password',
                    hintText: 'Enter old password',
                    onChanged: (value) => oldPassword = value,
                  ),
                  SizedBox(height: 16),
                  CostumFormTextField(
                    obscureText: true,
                    labelText: 'New Password',
                    hintText: 'Enter new password',
                    onChanged: (value) => newPassword = value,
                  ),
                  SizedBox(height: 16),
                  CostumFormTextField(
                    obscureText: true,
                    labelText: 'Confirm New Password',
                    hintText: 'Confirm new password',
                    onChanged: (value) => confirmPassword = value,
                  ),
                  SizedBox(height: 32),
                  CustomButton(
                    size: double.infinity,
                    text: 'change Password',
                    onTap: () {
                      changePassword();
                    },
                  )
                ],
              ),
            ),
    );
  }
}
