import 'package:excp_training/cubits/ReadTask/read_task_cubit.dart';
import 'package:excp_training/helper/custom_snack_bar.dart';
import 'package:excp_training/models/taske_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesItem extends StatelessWidget {
  NotesItem({super.key, this.isNew = true, this.onDelete, required this.taske});
  bool isNew;
  final TaskeModel taske;
  final VoidCallback? onDelete;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'task_view_page', arguments: taske);
        // Handle note item tap
      },
      child: Container(
        padding: EdgeInsets.only(top: 24, bottom: 24, left: 16),
        decoration: BoxDecoration(
          border: BorderDirectional(
            start: BorderSide(
              color: taske.isNew ? Colors.green : Colors.redAccent,
              width: 20,
            ),
            bottom: BorderSide(
              color: taske.isNew ? Colors.green : Colors.redAccent,
              width: 10,
            ),
          ),

          color: Color(0xffFFCC80),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(
              child: Text(
                taske.typeTask,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Pacifico',
                ),
              ),
            ),
            ListTile(
              title: Text(
                taske.title,
                style: TextStyle(color: Colors.black, fontSize: 28),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  maxLines: 1, //  يعرض سطر واحد فقط
                  overflow: TextOverflow.ellipsis,//لو النص طويل بيقصه 
                  taske.content,
                  style: TextStyle(
                    color: Colors.black.withValues(alpha: 0.4),
                    fontSize: 18,
                  ),
                ),
              ),
              trailing: taske.isNew
                  ? null
                  : IconButton(
                    
                      icon: Icon(Icons.delete, color: Colors.black, size: 30),
                      onPressed: () {
                        taske.delete();
                        BlocProvider.of<ReadTaskCubit>(context).fetchAllTaske();

                        showSnackBar(context, 'Taske Deleted');
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: Text(
                taske.date,
                style: TextStyle(
                  color: Colors.black.withValues(alpha: 0.4),
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
