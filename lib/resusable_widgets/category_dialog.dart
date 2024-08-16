// category_dialog.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uptodo/constants/colors.dart';
import 'package:uptodo/constants/text_styles.dart';
import 'package:uptodo/models/categories_models.dart';
import 'package:uptodo/screens/add_category.dart';
import 'package:uptodo/utils/dummy_data.dart';

class CategoryDialog extends StatelessWidget {
  final Function(String) onCategorySelected;

  const CategoryDialog({super.key, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: bottomNavBar,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Choose Category',
                style: s18RegGrey.copyWith(color: white87),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Divider(color: greyBorder, height: 1.5),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 1,
          ),
          itemCount: DummyData.categories.length,
          itemBuilder: (context, index) {
            final category = DummyData.categories[index];

            return _buildCategoryButton(context, category);
          },
        ),
      ),
      actions: <Widget>[
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Add Category'),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryButton(BuildContext context, Category category) {
    return GestureDetector(
      onTap: () {
        if (category.name == 'Create New') {
          Get.to(() => const AddCategory());
        } else {
          onCategorySelected(category.name);
          Navigator.of(context).pop();
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: category.color,
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Center(
              child: category.icon,
            ),
          ),
          const SizedBox(height: 10),
          Text(category.name, style: s14MedWhite87)
        ],
      ),
    );
  }
}
