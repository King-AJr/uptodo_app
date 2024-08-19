// category_dialog.dart
import 'package:flutter/material.dart';
import 'package:uptodo/utils/colors.dart';
import 'package:uptodo/utils/text_styles.dart';
import 'package:uptodo/resusable_widgets/custom_textfield.dart';

class ChangePasswordDialog extends StatelessWidget {
  const ChangePasswordDialog({super.key});

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
                'Change account Password',
                style: s16RegWhite87.copyWith(fontFamily: 'latoBold'),
              ),
              const SizedBox(height: 5),
            ],
          ),
          const SizedBox(height: 5),
          const Divider(color: greyBorder, height: 1.5),
        ],
      ),
      content: Container(
        width: double.infinity,
        height: 240,
        decoration: const BoxDecoration(
          color: bottomNavBar,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Column(
          children: [
            CustomTextField(
                hintText: 'Enter old password', label: 'Enter old password'),
            CustomTextField(
                hintText: 'Enter new password', label: 'Enter new password'),
          ],
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: s16RegWhite40.copyWith(color: appPurple),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Edit',
                style: s16RegWhite40.copyWith(color: appWhite),
              ),
            )
          ],
        ),
      ],
    );
  }
}
