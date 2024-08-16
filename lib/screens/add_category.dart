import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:uptodo/constants/colors.dart';
import 'package:uptodo/constants/text_styles.dart';
import 'package:uptodo/resusable_widgets/custom_textfield.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:uptodo/utils/helpers/helperFunctions.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  Color selectedColor = Colors.blue;
  IconData? selectedIcon = Icons.category;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Add listener to update the UI whenever the text changes
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text('Create new category', style: s20BoldWhite87),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
                hintText: 'Category name',
                label: 'Category name',
                controller: controller),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Category icon: ',
                  style: s16RegWhite40.copyWith(color: appWhite),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () async {
                    IconData? icon = await showIconPicker(
                      context,
                      iconColor: selectedColor,
                      iconPackModes: [IconPack.material],
                      title: Text('Pick an icon', style: s16RegWhite87),
                    );
                    if (icon != null) {
                      setState(() {
                        selectedIcon = icon;
                      });
                    }
                  },
                  child: Container(
                    height: 37,
                    width: 154,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: white21,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: Row(
                      children: [
                        if (selectedIcon != null)
                          Icon(selectedIcon,
                              color: getDarkerShade(selectedColor)),
                        const SizedBox(width: 10),
                        Text(
                          selectedIcon == null
                              ? "Choose icon from library"
                              : "Change icon",
                          style: s16RegWhite87.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Category color: ',
                  style: s16RegWhite40.copyWith(color: appWhite),
                ),
              ],
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                final Color? pickedColor = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: ColorPicker(
                        color: selectedColor,
                        onColorChanged: (Color color) {
                          setState(() {
                            selectedColor = color;
                          });
                        },
                        width: 40,
                        height: 40,
                        borderRadius: 22,
                        heading: Text(
                          'Select color',
                          style: s16RegWhite87.copyWith(fontSize: 12),
                        ),
                        subheading: Text(
                          'Select color shade',
                          style: s16RegWhite87.copyWith(fontSize: 12),
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: const Text('CANCEL'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('SELECT'),
                          onPressed: () {
                            Navigator.of(context).pop(selectedColor);
                          },
                        ),
                      ],
                    );
                  },
                );

                if (pickedColor != null) {
                  setState(() {
                    selectedColor = pickedColor;
                  });
                }
              },
              child: Container(
                width: 100,
                height: 37,
                decoration: BoxDecoration(
                  color: selectedColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    selectedColor == null
                        ? "Choose color from library"
                        : "Change color",
                    style: s16RegWhite87.copyWith(fontSize: 12),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: selectedColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          selectedIcon,
                          size: 40,
                          color: getDarkerShade(selectedColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(controller.text.trim(), style: s14MedWhite87)
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {},
              child: Text(
                'Cancel',
                style: s16RegWhite40.copyWith(color: appPurple),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Create category',
                style: s16RegWhite40.copyWith(color: appWhite),
              ),
            )
          ],
        ),
      ),
    );
  }
}
