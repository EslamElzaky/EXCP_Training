import 'package:excp_training/cubits/Categories/categories_cubit.dart';
import 'package:excp_training/cubits/ReadTask/read_task_cubit.dart';
import 'package:excp_training/cubits/task_cubit/task_cubit_cubit.dart';
import 'package:excp_training/helper/Custom_dropdown_field.dart';
import 'package:excp_training/helper/custom_button.dart';
import 'package:excp_training/helper/custom_snack_bar.dart';
import 'package:excp_training/helper/custom_text_field.dart';
import 'package:excp_training/models/taske_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ShowModelButtonBody extends StatelessWidget {
  ShowModelButtonBody({super.key});
  final TextEditingController dateController = TextEditingController();
  String? selectedType;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubitCubit, TaskCubitState>(
      listener: (context, state) {
        if (state is TaskCubitFiluer) {
          showSnackBar(context, 'Fealid');
        }
        if (state is TaskCubitSuccess) {
          BlocProvider.of<ReadTaskCubit>(context).fetchAllTaske();
          Navigator.pop(context);
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        return AbsorbPointer(
          absorbing: state is TaskCubitLoding ? true : false,
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: AddTaskFormFields(
              dateController: dateController,
              onTypeChanged: (val) {
                selectedType = val;
              },
            ),
          ),
        );
      },
    );
  }
}

class AddTaskFormFields extends StatefulWidget {
  final TextEditingController dateController;
  final void Function(String?) onTypeChanged;

  const AddTaskFormFields({
    super.key,
    required this.dateController,
    required this.onTypeChanged,
  });

  @override
  State<AddTaskFormFields> createState() => _AddTaskFormFieldsState();
}

class _AddTaskFormFieldsState extends State<AddTaskFormFields> {
  final GlobalKey<FormState> formKey = GlobalKey();

  String? title, content, typeTask, date;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          SizedBox(height: 24),

          // ✅ BlocBuilder لعرض التصنيفات من الكيوبت
          BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesLoaded) {
                final categories = state.categories;
                if (!categories.contains(typeTask)) {
                  typeTask = null;
                }
                return CustomDropdownField(
                  items: categories,
                  value: typeTask,
                  labelText: 'Type Task',
                  onChanged: (val) {
                    setState(() {
                      typeTask = val;
                    });
                  },
                  onSaved: (val) {
                    typeTask = val;
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),

          SizedBox(height: 24),
          CostumFormTextField(
            onSaved: (value) => title = value,
            labelText: 'Title',
            hintText: 'Title',
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 16),
          CostumFormTextField(
            onSaved: (value) => content = value,
            labelText: 'Content',
            hintText: 'Content',
            maxLines: 6,
          ),
          SizedBox(height: 16),
          CostumFormTextField(
            onSaved: (value) => date = value,
            labelText: 'Select Date',
            hintText: 'Tap to choose date',
            controller: widget.dateController,
            isDate: true,
          ),
          SizedBox(height: 50),

          BlocBuilder<TaskCubitCubit, TaskCubitState>(
            builder: (context, state) {
              return CustomButton(
                isLoding: state is TaskCubitLoding,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();

                    var taskModel = TaskeModel(
                      typeTask: typeTask!,
                      title: title!,
                      content: content!,
                      date: date!,
                    );

                    context.read<TaskCubitCubit>().addTask(taskModel);
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                  }
                  setState(() {});
                },
                size: double.infinity,
                text: 'Add Task',
              );
            },
          ),
        ],
      ),
    );
  }
}
