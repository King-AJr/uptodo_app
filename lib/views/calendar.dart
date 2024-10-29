import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uptodo/models/task_model.dart';
import 'package:uptodo/resusable_widgets/empty_list.dart';
import 'package:uptodo/resusable_widgets/task_card.dart';
import 'package:uptodo/utils/colors.dart';
import 'package:uptodo/utils/helperFunctions.dart';
import 'package:uptodo/utils/text_styles.dart';
import 'package:uptodo/resusable_widgets/horizontal_datepicker.dart';
import 'package:uptodo/view-models/task_vm.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  String selectedDate = DateTime.now().toIso8601String();
  Future<void>? fetchTasksFuture;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    fetchTasks();
    tabController.addListener(() {
      setState(() {});
    });
  }

  void updateSelectedDate(String newDate) {
    setState(() {
      selectedDate = newDate;
      fetchTasks();
    });
  }

  void fetchTasks() async {
    print(selectedDate);
    final vm = Provider.of<TaskVm>(context, listen: false);
    fetchTasksFuture = await vm.fethchSpecificDate(context, selectedDate);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TaskVm>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0.1,
        title: Text(
          'Calendar',
          style: s20BoldWhite87.copyWith(fontFamily: 'latoRegular'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HorizontalDatePicker(
              initialDate: DateTime.now(),
              onDateSelected: (selectedDate) {
                updateSelectedDate(selectedDate.toIso8601String());
              },
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    height: 80,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: bottomNavBar,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              tabController.animateTo(0);
                            },
                            child: Container(
                              height: 49,
                              width: 137,
                              decoration: BoxDecoration(
                                color: tabController.index == 0
                                    ? primaryColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: tabController.index == 0
                                      ? primaryColor
                                      : greyBorder,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 24),
                              child: Center(
                                child: Text(
                                  formatTaskTime(selectedDate, dateOnly: true),
                                  style: s16RegWhite40.copyWith(
                                    color: appWhite,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              tabController.animateTo(1);
                            },
                            child: Container(
                              height: 49,
                              width: 137,
                              decoration: BoxDecoration(
                                color: tabController.index == 1
                                    ? primaryColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: tabController.index == 1
                                      ? primaryColor
                                      : greyBorder,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 24),
                              child: Center(
                                child: Text(
                                  'Completed',
                                  style: s16RegWhite40.copyWith(
                                    color: appWhite,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FutureBuilder<void>(
                    future: fetchTasksFuture, // Use the Future variable
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return (vm.dateTaskIncomplete.isEmpty &&
                                vm.dateTaskComplete.isEmpty)
                            ? EmptyList(
                                message:
                                    "No task for ${formatTaskTime(selectedDate, dateOnly: true)}",
                              )
                            : SizedBox(
                                height: 400,
                                child: TabBarView(
                                  controller: tabController,
                                  children: [
                                    vm.dateTaskIncomplete.isNotEmpty
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            itemCount:
                                                vm.dateTaskIncomplete.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              Task task =
                                                  vm.dateTaskIncomplete[index];
                                              return TaskCard(task: task);
                                            },
                                          )
                                        : const EmptyList(
                                            message:
                                                "All specified tasks have been done",
                                          ),
                                    vm.dateTaskComplete.isNotEmpty
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            itemCount:
                                                vm.dateTaskComplete.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              Task task =
                                                  vm.dateTaskComplete[index];
                                              return TaskCard(task: task);
                                            },
                                          )
                                        : EmptyList(
                                            message:
                                                "No tasks for ${formatTaskTime(selectedDate, dateOnly: true)} has been completed",
                                          ),
                                  ],
                                ),
                              );
                      }
                    },
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
