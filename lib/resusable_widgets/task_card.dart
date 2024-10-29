// task_card.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uptodo/utils/colors.dart';
import 'package:uptodo/utils/helperFunctions.dart';
import 'package:uptodo/utils/text_styles.dart';
import 'package:uptodo/models/task_model.dart';
import 'package:uptodo/views/tasks.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => TaskScreen(task: task),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 7.5),
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
                value: task.completed,
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
                    Text(task.title ?? '', style: s16RegWhite87),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          task.completed == true
                              ? formatTaskTime(task.updatedAt)
                              : formatTaskTime(task.time),
                          style: s18RegGrey.copyWith(fontSize: 14),
                        ),
                        if (task.taskCategory != null &&
                            task.taskCategory != null)
                          Row(
                            children: [
                              Container(
                                width: 86,
                                height: 29,
                                decoration: BoxDecoration(
                                  color: task.taskCategory!.color,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      task.taskCategory!.icon,
                                      const SizedBox(width: 5),
                                      Text(task.taskCategory!.name,
                                          style: s12RegWhite),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              if (task.priority != null && task.priority! > 0)
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
                                      Text("${task.priority}",
                                          style: s12RegWhite)
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
      ),
    );
  }
}
