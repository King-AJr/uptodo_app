import 'package:flutter/material.dart';
import 'package:uptodo/constants/colors.dart';
import 'package:uptodo/constants/text_styles.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String time;
  final Color? tagColor;
  final String? taskCategory;
  final Icon? tagIcon;
  final int? priority;

  const TaskCard({
    super.key,
    required this.title,
    required this.time,
    this.tagColor,
    this.taskCategory,
    this.tagIcon,
    this.priority,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7.5),
      width: double.infinity,
      height: 72,
      decoration: const BoxDecoration(
        color: white21,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Checkbox(
              value: false,
              onChanged: null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: s16RegWhite87),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today At $time",
                        style: s18RegGrey.copyWith(fontSize: 14),
                      ),
                      // Conditional rendering based on taskCategory
                      if (taskCategory != null)
                        Row(
                          children: [
                            Container(
                              width: 86,
                              height: 29,
                              decoration: BoxDecoration(
                                color: tagColor,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (tagIcon != null) tagIcon!,
                                    if (tagIcon != null)
                                      const SizedBox(width: 5),
                                    Text(taskCategory!, style: s12RegWhite),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            if (priority != null)
                              Container(
                                width: 42,
                                height: 29,
                                decoration: BoxDecoration(
                                  border: Border.all(color: primaryColor),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Icon(Icons.tour_outlined,
                                        color: appWhite, size: 14),
                                    Text("$priority", style: s12RegWhite)
                                  ],
                                ),
                              )
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
