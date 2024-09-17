import 'package:flutter/material.dart';
import 'package:uptodo/utils/colors.dart';
import 'package:uptodo/utils/text_styles.dart';
import 'package:uptodo/models/task_model.dart';
import 'package:uptodo/resusable_widgets/horizontal_datepicker.dart';
import 'package:uptodo/resusable_widgets/task_card.dart';
import 'package:uptodo/utils/dummy_data.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  bool isTodaySelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0.1,
        title: Text(
          'Calendar',
          style: s20BoldWhite87.copyWith(fontFamily: 'latoRegular'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HorizontalDatePicker(
              initialDate: DateTime.now(),
              onDateSelected: (selectedDate) {
                print('Selected date: $selectedDate');
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Today Button
                          isTodaySelected
                              ? ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      isTodaySelected = true;
                                    });
                                  },
                                  child: Text(
                                    'Today',
                                    style:
                                        s16RegWhite40.copyWith(color: appWhite),
                                  ),
                                )
                              : OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      isTodaySelected = true;
                                    });
                                  },
                                  child: Text(
                                    'Today',
                                    style:
                                        s16RegWhite40.copyWith(color: appWhite),
                                  ),
                                ),
                          // Completed Button
                          !isTodaySelected
                              ? ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      isTodaySelected = false;
                                    });
                                  },
                                  child: Text(
                                    'Completed',
                                    style:
                                        s16RegWhite40.copyWith(color: appWhite),
                                  ),
                                )
                              : OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      isTodaySelected = false;
                                    });
                                  },
                                  child: Text(
                                    'Completed',
                                    style:
                                        s16RegWhite40.copyWith(color: appWhite),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (isTodaySelected)
                    ...DummyData.tasks.map((task) => TaskCard(task: task))
                  else
                    TaskCard(
                      task: Task(
                         null,
                        title: 'Business meeting with the CEO',
                        time: '08:15',
                      ),
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
