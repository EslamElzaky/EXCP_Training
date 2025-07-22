import 'package:excp_training/constant.dart';
import 'package:excp_training/cubits/Categories/categories_cubit.dart';
import 'package:excp_training/cubits/ReadTask/read_task_cubit.dart';
import 'package:excp_training/helper/Custom_dropdown_field.dart';
import 'package:excp_training/helper/custom_button.dart';
import 'package:excp_training/helper/custom_text_field.dart';
import 'package:excp_training/models/taske_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewTaskePage extends StatefulWidget {
  static String id = 'task_view_page';

  const ViewTaskePage({super.key});

  @override
  State<ViewTaskePage> createState() => _ViewTaskePageState();
}

class _ViewTaskePageState extends State<ViewTaskePage> {
  late TextEditingController titleController;
  late TextEditingController contentController;
  late TextEditingController dateController;
  String? selectedType = "sports";

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    contentController = TextEditingController();
    dateController = TextEditingController();
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
    final TaskeModel taske =
        ModalRoute.of(context)!.settings.arguments as TaskeModel;

    // إعداد القيم داخل الcontrollers
    titleController.text = taske.title;
    contentController.text = taske.content;
    dateController.text = taske.date;
    selectedType = taske.typeTask;

    return Scaffold(
      backgroundColor: kPrimarycolor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            const SizedBox(height: 24),
            BlocBuilder<CategoriesCubit, CategoriesState>(
              builder: (context, state) {
                List<String> categories = [];
                if (state is CategoriesLoaded) {
                  categories = state.categories;
                  // تأكد إن التصنيف الحالي موجود
                  if (!categories.contains(selectedType)) {
                    selectedType = null;
                  }
                }
                return CustomDropdownField(
                  items: categories,
                  labelText: 'Type Task',
                  value: selectedType,
                  isEnabled: false,
                  onChanged: (val) {
                    setState(() {
                      selectedType = val;
                    });
                  },
                );
              },
            ),
            const SizedBox(height: 24),
            CostumFormTextField(
              readOnly: true,
              labelText: 'Title',
              hintText: 'Title',
              keyboardType: TextInputType.text,
              obscureText: false,
              controller: titleController,
            ),
            const SizedBox(height: 16),
            CostumFormTextField(
              readOnly: true,
              labelText: 'Content',
              hintText: 'Content',
              maxLines: 6,
              controller: contentController,
            ),
            const SizedBox(height: 16),
            CostumFormTextField(
              
             readOnly: true,
              labelText: 'Select Date',
              hintText: 'Tap to choose date',
              controller: dateController,
              isDate: true,
            ),
            const SizedBox(height: 50),
            CustomButton(
              size: double.infinity,
              text: 'Edit Task',
              onTap: () async {
                final result = await Navigator.pushNamed(
                  context,
                  'EidtTaskePage',
                  arguments: taske,
                );

                if (result == true && mounted) {
                  BlocProvider.of<ReadTaskCubit>(context).fetchAllTaske();
                  setState(() {}); // لو الصفحة Stateful
                }
              },
            ),
            const SizedBox(height: 25),
            CustomButton(
              size: double.infinity,
              text: 'Finish Task',
              onTap: () async {
                taske.isNew = false;
                await taske.save(); // تحديث Hive

                // تحديث الواجهة
                if (mounted) {
                  Navigator.pop(context); // نرجع للشاشة الرئيسية
                  BlocProvider.of<ReadTaskCubit>(context).fetchAllTaske();
                  // ممكن تضيف حذف أو تغيير حالة هنا
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
