import 'dart:math';

import 'package:excp_training/helper/hive/hive_keys.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HiveFun {
  static Future<void> setRememberMe(bool value) async {
    final box = await Hive.openBox(HiveKeys.loginBox);
    await box.put(HiveKeys.rememberMe, value);
  }

  static Future<bool> getRememberMe() async {
    final box = await Hive.openBox(HiveKeys.loginBox);
    return box.get(HiveKeys.rememberMe, defaultValue: false);
  }

  static Future<void> setUser(String email, String password) async {
    final box = await Hive.openBox(HiveKeys.loginBox);
    await box.put(HiveKeys.email, email);
    await box.put(HiveKeys.password, password);
  }

  static Future<String?> getEmail() async {
    final box = await Hive.openBox(HiveKeys.loginBox);
    return box.get(HiveKeys.email);
  }

  static Future<String?> getPassword() async {
    final box = await Hive.openBox(HiveKeys.loginBox);
    return box.get(HiveKeys.password);
  }

  static Future<bool> userLogin(BuildContext context) async {
    bool rememberMe = await HiveFun.getRememberMe();
    if (rememberMe) {
     String? email = await HiveFun.getEmail();
     String? password = await HiveFun.getPassword();
      try {
        Future<void> logInUsers() async {
          UserCredential user = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email!, password: password!);
        }
        await HiveFun.setRememberMe(true);
        Navigator.pushNamed(context, 'BottomNavigation');
      } catch (e) {
        throw Exception('Failed to log in: $e');
      }
      return true;
    } else {
      return false;
    }
  }
}
