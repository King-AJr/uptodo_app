import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:provider/provider.dart';
import 'package:uptodo/models/categories_models.dart';
import 'package:uptodo/resusable_widgets/alerts.dart';
import 'package:uptodo/resusable_widgets/category_dialog.dart';
import 'package:uptodo/resusable_widgets/priority_dialog.dart';
import 'package:uptodo/utils/colors.dart';
import 'package:uptodo/utils/helperFunctions.dart';
import 'package:uptodo/utils/text_styles.dart';
import 'package:uptodo/utils/validators.dart';
import 'package:uptodo/view-models/task_vm.dart';
import 'package:uptodo/views/calendar.dart';
import 'package:uptodo/views/focus_mode.dart';
import 'package:uptodo/views/home.dart';
import 'package:uptodo/views/profile.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;
  DateTime? selectedDateTime;
  Category? selectedCategory;
  int? selectedPriority;

  final List<Widget> _screens = [
    const HomeScreen(),
    const CalendarScreen(),
    Container(),
    const FocusModeScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: bgColor,
        selectedIndex: _currentIndex,
        showElevation: true,
        onItemSelected: (index) {
          if (index == 2) {
            _showAddTaskModal(context);
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: [
          BottomNavyBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home'),
            activeColor: appWhite,
            inactiveColor: appWhite,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.calendar_month),
            title: const Text('Calendar'),
            activeColor: appWhite,
            inactiveColor: appWhite,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.add),
            title: const Text('Add'),
            activeColor: purpleButton,
            inactiveColor: purpleButton,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.access_time),
            title: const Text('Focus'),
            activeColor: appWhite,
            inactiveColor: appWhite,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.person),
            title: const Text('Profile'),
            activeColor: appWhite,
            inactiveColor: appWhite,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Function to handle "Add Task" button press
  void _showAddTaskModal(BuildContext context) {
    final vm = Provider.of<TaskVm>(context, listen: false);
    final formKey = GlobalKey<FormState>();

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
          padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom),
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
                        vm.addTask(context);
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
