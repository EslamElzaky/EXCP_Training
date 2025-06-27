import 'package:excp_training/constant.dart';
import 'package:excp_training/helper/custom_home_body.dart';
import 'package:excp_training/helper/show_Model_button_body.dart';
import 'package:excp_training/views/profile_page.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static String id = 'HomeView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.blueGrey,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pushNamed(context, ProfilePage.id);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {},
            ),
          ],
        ),
      ),
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
                    child: ShowModelButtonBody());
              });
        },
        child: Icon(Icons.add),
      ),
      body: CustomHomeBody(),
    );
  }
}
