import 'package:excp_training/constant.dart';
import 'package:excp_training/cubits/Categories/categories_cubit.dart';

import 'package:excp_training/helper/bottom_navigation.dart';
import 'package:excp_training/helper/custom_button.dart';
import 'package:excp_training/views/add_category_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageCategoriesPage extends StatelessWidget {
  static String id = 'categories_page';

  const ManageCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimarycolor,
      appBar: AppBar(
        title: Text('Manage Categories'),
        backgroundColor: Colors.blueGrey.withOpacity(0.2),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(
              context, BottomNavigation.id);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 16),

            // لعرض التصنيف 
            Expanded(
              child: BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoriesLoaded) {
                    final categories = state.categories;

                    return ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(categories[index]),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.black),
                            onPressed: () {
                              context.read<CategoriesCubit>().removeCategory(
                                categories[index],
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),

            CustomButton(
              size: double.infinity,
              text: 'Add Category',
              onTap: () async {
                final newCategory = await Navigator.push<String>(
                  context,
                  MaterialPageRoute(builder: (_) => AddCategoryPage()),
                );

                if (newCategory != null && newCategory.trim().isNotEmpty) {
                  BlocProvider.of<CategoriesCubit>(
                    context,
                  ).addCategory(newCategory.trim());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
