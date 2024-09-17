import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uptodo/models/categories_models.dart';
import 'package:uptodo/utils/colors.dart';
import 'package:uptodo/utils/sizes.dart';
import 'package:uptodo/utils/text_styles.dart';
import 'package:uptodo/models/task_model.dart';
import 'package:uptodo/resusable_widgets/category_dialog.dart';
import 'package:uptodo/resusable_widgets/deletetask_dialog.dart';
import 'package:uptodo/resusable_widgets/priority_dialog.dart';
import 'package:uptodo/views/bottom_nav_bar.dart';
import 'package:uptodo/utils/helperFunctions.dart';

class TaskScreen extends StatelessWidget {
  final Task task;

  TaskScreen({
    super.key,
    required this.task,
  });

  DateTime? selectedDateTime;
  Category? selectedCategory;
  int? selectedPriority;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
          child: Column(
            children: [
              _buildActionBar(context),
              const SizedBox(height: 20),
              _buildTaskInfo(context),
              Row(
                children: [
                  const SizedBox(width: 60),
                  Text(
                    task.description ?? '',
                    style: s16RegWhite40.copyWith(color: greyText),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              _buildInfoRow(
                icon: Icons.timer_outlined,
                label: 'Task Time:',
                content: "Today at ${task.time}",
              ),
              const SizedBox(height: 30),
              _buildInfoRow(
                icon: Icons.sell_outlined,
                label: 'Task Category:',
                content: task.taskCategory!.name ?? '',
                leadingWidget: task.taskCategory!.icon,
              ),
              const SizedBox(height: 30),
              _buildInfoRow(
                icon: Icons.tour_outlined,
                label: 'Task Priority:',
                content: task.priority != null ? "${task.priority}" : "Default",
              ),
              const SizedBox(height: 30),
              _buildInfoRow(
                icon: Icons.device_hub_outlined,
                label: 'Sub-Task:',
                content: "Add Sub-Task",
              ),
              const SizedBox(height: 50),
              _buildDeleteButton(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Edit Task'),
        ),
      ),
    );
  }

  // Build the action bar with close and repeat buttons
  Widget _buildActionBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildIconButton(Icons.close, () {
          Navigator.pop(context);
        }),
        _buildIconButton(Icons.loop_sharp, () {
          _showAddTaskModal(context);
        }),
      ],
    );
  }

  // Reusable widget for icon buttons
  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: const BoxDecoration(
        color: buttonGrey,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: IconButton(
        icon: Icon(icon, size: 24),
        onPressed: onPressed,
      ),
    );
  }

  // Build the task info section with a checkbox and title
  Widget _buildTaskInfo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: false,
              fillColor: WidgetStateProperty.all(const Color(0xff363636)),
              onChanged: null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              task.title ?? '',
              style: s20BoldWhite87.copyWith(fontFamily: 'latoRegular'),
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.border_color_outlined, size: 24),
          onPressed: () {
            _showAddTaskModal(context);
          },
        ),
      ],
    );
  }

  // Reusable widget for information rows
  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String content,
    Widget? leadingWidget,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, size: Sizes.iconSize, color: appWhite),
            const SizedBox(width: 10),
            Text(label, style: s16RegWhite87),
          ],
        ),
        Container(
          height: 37,
          padding: const EdgeInsets.all(7),
          decoration: const BoxDecoration(
            color: white21,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (leadingWidget != null) ...[
                  leadingWidget,
                  const SizedBox(width: 10),
                ],
                Text(content, style: s16RegWhite87.copyWith(fontSize: 12)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Build the delete button section
  Widget _buildDeleteButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => DeleteTaskDialog(title: task.title ?? ''),
        );
      },
      child: Container(
        color: bgColor,
        child: Row(
          children: [
            const Icon(Icons.delete_forever_outlined,
                size: Sizes.iconSize, color: appRed),
            const SizedBox(width: 10),
            Text('Delete Task', style: s16RegWhite40.copyWith(color: appRed)),
          ],
        ),
      ),
    );
  }

  void _showAddTaskModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: bottomNavBar,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Add Task',
                    style: s32BoldWhite.copyWith(
                      fontSize: 20,
                      color: white87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Description", style: s18RegGrey),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.timer_outlined, size: 24),
                        onPressed: () async {
                          selectedDateTime = await pickDateTime(context);
                          if (selectedDateTime != null) {
                            print('Selected DateTime: $selectedDateTime');
                          }
                        },
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: const Icon(Icons.sell_outlined, size: 24),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => CategoryDialog(
                              onCategorySelected: (category) {
                                selectedCategory = category;
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: const Icon(Icons.tour_outlined, size: 24),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => PriorityDialog(
                              onPrioritySelected: (priority) {
                                selectedPriority = priority;
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const Icon(Icons.send_outlined, size: 24),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
