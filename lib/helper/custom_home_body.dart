import 'package:excp_training/cubits/ReadTask/read_task_cubit.dart';
import 'package:excp_training/helper/custom_appBar.dart';
import 'package:excp_training/helper/custom_taske_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomHomeBody extends StatefulWidget {
  const CustomHomeBody({super.key});

  @override
  State<CustomHomeBody> createState() => _CustomHomeBodyState();
}

class _CustomHomeBodyState extends State<CustomHomeBody> {
  @override
  void initState() {
    BlocProvider.of<ReadTaskCubit>(context).fetchAllTaske();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          SizedBox(height: 50),
          CustomAppbar(text: 'Notes'),
          Expanded(child: TaskeListView()),
        ],
      ),
    );
  }
}
