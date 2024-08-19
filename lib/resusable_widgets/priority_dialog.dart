import 'package:flutter/material.dart';
import 'package:uptodo/utils/colors.dart';
import 'package:uptodo/utils/sizes.dart';
import 'package:uptodo/utils/text_styles.dart';

class PriorityDialog extends StatefulWidget {
  final Function(int) onPrioritySelected;
  const PriorityDialog({super.key, required this.onPrioritySelected});

  @override
  _PriorityDialogState createState() => _PriorityDialogState();
}

class _PriorityDialogState extends State<PriorityDialog> {
  int? selectedPriority;

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
                'Choose Priority',
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
            crossAxisCount: 4,
            mainAxisSpacing: 15,
            crossAxisSpacing: 8,
            childAspectRatio: 0.8,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            // Increment index by 1 to start priorities from 1
            final int priority = index + 1;

            return _buildPriorityButton(context, priority);
          },
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: s16RegWhite40.copyWith(color: appPurple),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedPriority != null) {
                  widget.onPrioritySelected(selectedPriority!);
                  Navigator.of(context).pop();
                }
              },
              child: Text(
                'Save',
                style: s16RegWhite40.copyWith(color: appWhite),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildPriorityButton(BuildContext context, int priority) {
    final bool isSelected = selectedPriority == priority;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPriority = priority;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: isSelected ? appPurple : const Color(0xff272727),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Column(
          children: [
            const Icon(Icons.tour_outlined,
                size: Sizes.iconSize, color: appWhite),
            const SizedBox(height: 10),
            Text("$priority", style: s16RegWhite87),
          ],
        ),
      ),
    );
  }
}
