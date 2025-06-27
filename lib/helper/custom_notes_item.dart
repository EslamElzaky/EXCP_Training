import 'package:flutter/material.dart';

class NotesItem extends StatelessWidget {
  const NotesItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'task_edit_page');
        // Handle note item tap
      },
      child: Container(
        padding: EdgeInsets.only(top: 24, bottom: 24, left: 16),
        decoration: BoxDecoration(
          color: Color(0xffFFCC80),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ListTile(
              title: Text(
                'Tasks Daily',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text('How to work this day',
                    style: TextStyle(
                      color: Colors.black.withValues(alpha: 0.4),
                      fontSize: 18,
                    )),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  // Handle delete action
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: Text('may23,2025',
                  style: TextStyle(
                    color: Colors.black.withValues(alpha: 0.4),
                    fontSize: 16,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
