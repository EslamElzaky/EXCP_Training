import 'package:excp_training/helper/custom_appBar.dart';
import 'package:excp_training/helper/custom_home_body.dart';
import 'package:excp_training/helper/custom_text_field.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(29)),
              context: context,
              builder: (context) {
                return ShowNotesButton();
              });
        },
        child: Icon(Icons.add),
      ),
      body: CustomHomeBody(),
    );
  }
}

class ShowNotesButton extends StatelessWidget {
  const ShowNotesButton({super.key});

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
            labelText: 'Date',
            hintText: 'Enter date',
            keyboardType: TextInputType.datetime,
            obscureText: false,
          ),
        ],
      ),
    );
  }
}
