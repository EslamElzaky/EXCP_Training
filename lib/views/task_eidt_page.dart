import 'package:excp_training/constant.dart';
import 'package:excp_training/helper/Custom_dropdown_field.dart';
import 'package:excp_training/helper/custom_button.dart';
import 'package:excp_training/helper/custom_text_field.dart';
import 'package:flutter/material.dart';

class TaskEidtPage extends StatelessWidget {
  TaskEidtPage({super.key});
  static String id = 'task_edit_page';
  TextEditingController dateController = TextEditingController();
  String? selectedType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimarycolor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          
          children: [
            SizedBox(
              height: 24,
            ),
            CustomDropdownField(
              items: ['study', 'sports', 'Games', 'work', 'others'],
              labelText: 'Type Task',
              value: selectedType,
              onChanged: (val) {
                selectedType = val;
              },
            ),
            SizedBox(
              height: 24,
            ),
            CostumFormTextField(
              labelText: 'Title',
              hintText: 'Title',
              keyboardType: TextInputType.text,
              obscureText: false,
            ),
            SizedBox(
              height: 16,
            ),
            CostumFormTextField(
              labelText: 'Content',
              hintText: 'Content',
              maxLines: 6,
            ),
            SizedBox(
              height: 16,
            ),
            CostumFormTextField(
              labelText: 'Select Date',
              hintText: 'Tap to choose date',
              controller: dateController,
              isDate: true,
            ),
            SizedBox(
              height: 50,
            ),
            CustomButton(
              size: double.infinity,
              text: 'Add Taske',
            )
          ],
        ),
      ),
    );
    ;
  }
}
