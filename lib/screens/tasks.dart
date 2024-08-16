import 'package:flutter/material.dart';
import 'package:uptodo/constants/colors.dart';
import 'package:uptodo/constants/sizes.dart';
import 'package:uptodo/constants/text_styles.dart';
import 'package:uptodo/models/task_model.dart';

class TaskScreen extends StatelessWidget {
  final Task task;

  const TaskScreen({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
          child: Column(
            children: [
              _buildActionBar(),
              const SizedBox(height: 20),
              _buildTaskInfo(),
              const SizedBox(height: 30),
              _buildTaskTime(),
              const SizedBox(height: 30),
              _buildTaskCategory(),
              const SizedBox(height: 30),
              _buildTaskPriority(),
              const SizedBox(height: 30),
              _buildSubTask(),
              const SizedBox(height: 50),
              _buildDeleteButton(),
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
  Widget _buildActionBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildIconButton(Icons.close, () {}),
        _buildIconButton(Icons.loop_sharp, () {}),
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
  Widget _buildTaskInfo() {
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
              task.title,
              style: s20BoldWhite87.copyWith(fontFamily: 'latoRegular'),
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.border_color_outlined, size: 24),
          onPressed: () {},
        ),
      ],
    );
  }

  // Build the task time section
  Widget _buildTaskTime() {
    return _buildInfoRow(
      icon: Icons.timer_outlined,
      label: 'Task Time:',
      content: "Today at ${task.time}",
    );
  }

  // Build the task category section
  Widget _buildTaskCategory() {
    return _buildInfoRow(
      icon: Icons.sell_outlined,
      label: 'Task Category:',
      content: task.taskCategory ?? '',
      leadingWidget: task.tagIcon,
    );
  }

  // Build the task priority section
  Widget _buildTaskPriority() {
    return _buildInfoRow(
      icon: Icons.tour_outlined,
      label: 'Task Priority:',
      content: task.priority != null ? "${task.priority}" : "Default",
    );
  }

  // Build the sub-task section
  Widget _buildSubTask() {
    return _buildInfoRow(
      icon: Icons.device_hub_outlined,
      label: 'Sub-Task:',
      content: "Add Sub-Task",
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
  Widget _buildDeleteButton() {
    return Container(
      color: bgColor,
      child: Row(
        children: [
          const Icon(Icons.delete_forever_outlined,
              size: Sizes.iconSize, color: appRed),
          const SizedBox(width: 10),
          Text('Delete Task', style: s16RegWhite40.copyWith(color: appRed)),
        ],
      ),
    );
  }
}
