// category_dialog.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uptodo/utils/colors.dart';
import 'package:uptodo/utils/text_styles.dart';
import 'package:uptodo/view-models/task_vm.dart';

class DeleteTaskDialog extends StatelessWidget {
  final String title;
  final int? id;
  const DeleteTaskDialog({super.key, required this.title, this.id});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TaskVm>(context);
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
                'Delete task',
                style: s16RegWhite87.copyWith(fontFamily: 'latoBold'),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Divider(color: greyBorder, height: 1.5),
        ],
      ),
      content: Container(
        width: double.infinity,
        height: 85,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
          color: bottomNavBar,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Column(
          children: [
            Text(
              textAlign: TextAlign.center,
              'Are you sure you want to delete this task?\ntask title: $title',
              style: s16RegWhite87.copyWith(
                fontFamily: 'latoMedium',
                fontSize: 18,
                height: 1.5,
              ),
            ),
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
              onPressed: () {
                vm.deleteTask(id);
              },
              child: Text(
                'Delete',
                style: s16RegWhite40.copyWith(color: appWhite),
              ),
            )
          ],
        ),
      ],
    );
  }
}
