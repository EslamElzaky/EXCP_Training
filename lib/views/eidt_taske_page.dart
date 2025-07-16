
import 'package:excp_training/constant.dart';
import 'package:excp_training/cubits/Categories/categories_cubit.dart';
import 'package:excp_training/helper/Custom_dropdown_field.dart';
import 'package:excp_training/helper/custom_button.dart';
import 'package:excp_training/helper/custom_text_field.dart';
import 'package:excp_training/models/taske_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditTaskPage extends StatefulWidget {
  static const String id = 'EidtTaskePage';

  const EditTaskPage({super.key});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  late TextEditingController titleController;
  late TextEditingController contentController;
  late TextEditingController dateController;
  String? selectedType;
  bool _isInitialized = false;
  late TaskeModel taske;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    contentController = TextEditingController();
    dateController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      taske = ModalRoute.of(context)!.settings.arguments as TaskeModel;
      titleController.text = taske.title;
      contentController.text = taske.content;
      dateController.text = taske.date;
      selectedType = taske.typeTask;
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimarycolor,
      appBar: AppBar(title: Text('Edit Task'), backgroundColor: kPrimarycolor),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
           
            BlocBuilder<CategoriesCubit, CategoriesState>(
              builder: (context, state) {
                if (state is CategoriesLoaded) {
                  final categories = state.categories;
                  if (!categories.contains(selectedType)) {
                    selectedType = null;
                  }

                  return CustomDropdownField(

                    items: categories,
                    labelText: 'Type Task',
                    value: selectedType,
                    onChanged: (val) {
                      setState(() => selectedType = val);
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),

            SizedBox(height: 16),
            CostumFormTextField(
              controller: titleController,
              labelText: 'Title',
              hintText: 'Title',
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 16),
            CostumFormTextField(
              controller: contentController,
              labelText: 'Content',
              hintText: 'Content',
              maxLines: 6,
            ),
            SizedBox(height: 16),
            CostumFormTextField(
              controller: dateController,
              labelText: 'Select Date',
              hintText: 'Tap to choose date',
              isDate: true,
            ),
            SizedBox(height: 32),
            CustomButton(
              text: 'Save',
              size: double.infinity,
              onTap: () async {
                taske.title = titleController.text;
                taske.content = contentController.text;
                taske.date = dateController.text;
                taske.typeTask = selectedType ?? 'others';

                await taske.save();

                if (!mounted) return;

                Navigator.pop(context, true);
              },
            ),
          ],
        ),
      ),
    );
  }
}
