import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:uptodo/models/categories_models.dart';
import 'package:uptodo/resusable_widgets/alerts.dart';
import 'package:uptodo/utils/colors.dart';
import 'package:uptodo/utils/text_styles.dart';
import 'package:uptodo/resusable_widgets/category_dialog.dart';
import 'package:uptodo/resusable_widgets/priority_dialog.dart';
import 'package:uptodo/utils/validators.dart';
import 'package:uptodo/view-models/task_vm.dart';
import 'package:uptodo/views/calendar.dart';
import 'package:uptodo/views/focus_mode.dart';
import 'package:uptodo/views/home.dart';
import 'package:uptodo/views/profile.dart';
import 'package:uptodo/utils/helperFunctions.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});

  final _controller = PersistentTabController(initialIndex: 0);
  DateTime? selectedDateTime;
  Category? selectedCategory;
  int? selectedPriority;

  @override
  Widget build(BuildContext context) {
    final bool empty = false;
    return PersistentTabView(
      backgroundColor: bottomNavBar,
      context,
      controller: _controller,
      screens: [
        HomeScreen(empty: empty),
        const CalendarScreen(),
        HomeScreen(empty: empty),
        const FocusModeScreen(),
        const ProfileScreen()
      ],
      items: [
        PersistentBottomNavBarItem(
          inactiveIcon: const Icon(Icons.home_outlined, color: appWhite),
          icon: const Icon(Icons.home, color: appWhite),
          iconSize: 24,
          title: ("Index"),
          textStyle: s12RegWhite,
          activeColorPrimary: appWhite,
          inactiveColorPrimary: appWhite,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.calendar_month, color: appWhite),
          inactiveIcon:
              const Icon(Icons.calendar_month_outlined, color: appWhite),
          iconSize: 24,
          title: ("Calendar"),
          textStyle: s12RegWhite,
          activeColorPrimary: appWhite,
          inactiveColorPrimary: appWhite,
        ),
        PersistentBottomNavBarItem(
          inactiveIcon: const Icon(Icons.add_outlined, color: appWhite),
          icon: const Icon(Icons.add, color: appWhite),
          iconSize: 32,
          activeColorPrimary: purpleButton,
          inactiveColorPrimary: purpleButton,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.access_time, color: appWhite),
          inactiveIcon: const Icon(Icons.access_time_outlined, color: appWhite),
          title: ("Focus"),
          iconSize: 24,
          textStyle: s12RegWhite,
          activeColorPrimary: appWhite,
          inactiveColorPrimary: appWhite,
        ),
        PersistentBottomNavBarItem(
          inactiveIcon: const Icon(Icons.person_2),
          icon: const Icon(Icons.person_2_outlined),
          iconSize: 24,
          title: ("Profile"),
          textStyle: s12RegWhite,
          activeColorPrimary: appWhite,
          inactiveColorPrimary: appWhite,
        ),
      ],
      onItemSelected: (index) {
        if (index == 2) {
          _showAddTaskModal(context);
        }
      },
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardAppears: true,
      padding: const EdgeInsets.only(top: 8),
      isVisible: true,
      confineToSafeArea: true,
      navBarHeight: kBottomNavigationBarHeight,
      navBarStyle: NavBarStyle.style15,
    );
  }

  void _showAddTaskModal(BuildContext context) {
    final vm = Provider.of<TaskVm>(context, listen: false);
    final formKey = GlobalKey<FormState>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: bottomNavBar,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
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
                TextFormField(
                  controller: vm.title,
                  validator: (value) => validateString(value),
                  decoration: InputDecoration(
                    hintText: 'Task title',
                    hintStyle: s16RegWhite40.copyWith(color: hintColor),
                  ),
                  style: s16RegWhite40.copyWith(color: appWhite),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Description", style: s18RegGrey),
                  ],
                ),
                TextFormField(
                  controller: vm.description,
                  validator: (value) => validateString(value),
                  decoration: InputDecoration(
                    hintText: 'Task description',
                    hintStyle: s16RegWhite40.copyWith(color: hintColor),
                  ),
                  style: s16RegWhite40.copyWith(color: appWhite),
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
                              vm.selectedDateTime = selectedDateTime;
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
                                  vm.selectedCategory = selectedCategory;
                                  print(vm.selectedCategory);
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
                                  vm.selectedPriority = priority;
                                  print(vm.selectedPriority);
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
