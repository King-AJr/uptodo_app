import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:uptodo/constants/colors.dart';
import 'package:uptodo/constants/text_styles.dart';
import 'package:uptodo/screens/home.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({Key? key}) : super(key: key);

  final _controller = PersistentTabController(initialIndex: 0);
  DateTime? selectedDateTime; // To store the selected date and time
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final bool empty = false;
    return PersistentTabView(
      backgroundColor: bottomNavBar,
      context,
      controller: _controller,
      screens: [
        HomeScreen(empty: empty),
        Container(color: Colors.blue),
        HomeScreen(empty: empty),
        Container(color: Colors.red),
        Container(color: Colors.black),
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
                        onPressed: () => _selectDateTime(context),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: const Icon(Icons.sell_outlined, size: 24),
                        onPressed: () {
                        },
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: const Icon(Icons.tour_outlined, size: 24),
                        onPressed: () {},
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

  Future<void> _selectDateTime(BuildContext context) async {
    // Show the date picker first
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      // Show the time picker next
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      // If a time was selected, combine date and time
      if (selectedTime != null) {
        selectedDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        print('Selected DateTime: $selectedDateTime');
      }
    }
  }
}
