import 'package:excp_training/helper/custom_icons.dart';
import 'package:excp_training/views/profile_page.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Notes',
          style: TextStyle(
            fontSize: 28,
          ),
        ),
        Spacer(),
        CustomIcons(
          onTap: () {
            Navigator.pushNamed(context, ProfilePage.id);
          },
          icon: Icon(Icons.search),
        ),
      ],
    );
  }
}
