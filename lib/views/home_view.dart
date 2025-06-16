import 'package:excp_training/helper/custom_appBar.dart';
import 'package:excp_training/helper/custom_home_body.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomHomeBody(),

    );
  }
}