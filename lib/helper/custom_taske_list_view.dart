import 'package:excp_training/cubits/ReadTask/read_task_cubit.dart';
import 'package:excp_training/helper/custom_notes_item.dart';
import 'package:excp_training/models/taske_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/gestures.dart';

class TaskeListView extends StatelessWidget {
  const TaskeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadTaskCubit, ReadTaskState>(
      builder: (context, state) {
        if (state is ReadTaskSuccess) {
          final List<TaskeModel> taske = state.taske;
          if (taske.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image_not_supported_sharp,
                    size: 100,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 16),
                  Text('There are no Tasks ', style: TextStyle(fontSize: 20)),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ListView.builder(
              dragStartBehavior: DragStartBehavior.start,
              itemCount: taske.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: NotesItem(taske: taske[index]),
                );
              },
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
