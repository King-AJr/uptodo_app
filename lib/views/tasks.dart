import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uptodo/models/categories_models.dart';
import 'package:uptodo/resusable_widgets/alerts.dart';
import 'package:uptodo/resusable_widgets/update_task_dialog.dart';
import 'package:uptodo/utils/colors.dart';
import 'package:uptodo/utils/sizes.dart';
import 'package:uptodo/utils/text_styles.dart';
import 'package:uptodo/models/task_model.dart';
import 'package:uptodo/resusable_widgets/category_dialog.dart';
import 'package:uptodo/resusable_widgets/deletetask_dialog.dart';
import 'package:uptodo/resusable_widgets/priority_dialog.dart';
import 'package:uptodo/utils/validators.dart';
import 'package:uptodo/view-models/task_vm.dart';
import 'package:uptodo/utils/helperFunctions.dart';

class TaskScreen extends StatefulWidget {
  final Task task;

  TaskScreen({
    super.key,
    required this.task,
  });

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  DateTime? selectedDateTime;

  Category? selectedCategory;

  int? selectedPriority;

  @override
  Widget build(BuildContext context) {
    bool isSelected = false;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
          child: Column(
            children: [
              _buildActionBar(context),
              const SizedBox(height: 20),
              _buildTaskInfo(context),
              const SizedBox(height: 40),
              _buildInfoRow(
                icon: Icons.timer_outlined,
                label: 'Task Time:',
                content: widget.task.completed == true
                    ? formatTaskTime(widget.task.updatedAt)
                    : formatTaskTime(widget.task.time),
              ),
              const SizedBox(height: 30),
              _buildInfoRow(
                icon: Icons.sell_outlined,
                label: 'Task Category:',
                content: widget.task.taskCategory!.name ?? '',
                leadingWidget: widget.task.taskCategory!.icon,
              ),
              const SizedBox(height: 30),
              _buildInfoRow(
                icon: Icons.tour_outlined,
                label: 'Task Priority:',
                content: widget.task.priority != null
                    ? "${widget.task.priority}"
                    : "Default",
              ),
              const SizedBox(height: 30),
              const SizedBox(height: 50),
              _buildDeleteButton(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            _showAddTaskModal(context);
          },
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

  Widget _buildTaskInfo(BuildContext context) {
    bool isSelected = false;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Checkbox(
                value: widget.task.completed,
                fillColor: WidgetStateProperty.all(const Color(0xff363636)),
                onChanged: (bool? value) {
                  setState(() {
                    isSelected = value ?? false;
                  });

                  if (isSelected) {
                    showDialog(
                      context: context,
                      builder: (context) => UpdateTaskDialog(
                        task: widget.task,
                      ),
                    );
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.title ?? '',
                      style: s20BoldWhite87.copyWith(fontFamily: 'latoRegular'),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      maxLines: null,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.task.description ?? '',
                      style: s16RegWhite40.copyWith(color: greyText),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ],
                ),
              ),
            ],
          ),
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
          builder: (context) => DeleteTaskDialog(
              title: widget.task.title ?? '', id: widget.task.id),
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
    final vm = Provider.of<TaskVm>(context, listen: false);
    final formKey = GlobalKey<FormState>();
    vm.title.text = widget.task.title ?? '';
    vm.description.text = widget.task.description ?? '';
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
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Edit Task',
                      style: s32BoldWhite.copyWith(
                        fontSize: 20,
                        color: white87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Title',
                      style: s16RegWhite40.copyWith(color: appWhite),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: vm.title,
                  validator: (value) => validateString(value),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: s16RegWhite40.copyWith(color: appWhite),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  maxLines: 4,
                  controller: vm.description,
                  validator: (value) => validateString(value),
                ),
                const SizedBox(height: 20),
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
                              
                              vm.selectedDateTime = selectedDateTime;
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
                                  vm.selectedCategory = selectedCategory;
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
                                  vm.selectedPriority = selectedPriority;
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }
                        if (vm.selectedCategory == null ||
                            vm.selectedDateTime == null ||
                            vm.selectedPriority == null) {
                          errorAlert(
                            'Task time, date, category and priority must be selected',
                          );
                          return;
                        }
                        vm.updateTask(widget.task);
                      },
                      icon: const Icon(Icons.send_outlined, size: 24),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
