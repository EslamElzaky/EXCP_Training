import 'package:excp_training/helper/custom_appBar.dart';
import 'package:excp_training/helper/custom_notes_item.dart';
import 'package:flutter/material.dart';

class CustomHomeBody extends StatelessWidget {
  const CustomHomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          CustomAppbar(),
          NotesItem(),
        ],
      ),
    );
  }
}
