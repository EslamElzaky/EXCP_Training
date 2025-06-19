import 'package:excp_training/constant.dart';
import 'package:excp_training/helper/custom_button.dart';
import 'package:excp_training/helper/custom_home_body.dart';
import 'package:excp_training/helper/custom_text_field.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static String id = 'HomeView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimarycolor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: kPrimarycolor,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(29)),
              context: context,
              builder: (context) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: ShowNotesButton());
              });
        },
        child: Icon(Icons.add),
      ),
      body: CustomHomeBody(),
    );
  }
}

class ShowNotesButton extends StatelessWidget {
  ShowNotesButton({super.key});
  TextEditingController dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView(
        children: [
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
            text: 'Add Notes',
          )
        ],
      ),
    );
  }
}
