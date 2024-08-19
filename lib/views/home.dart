// home_screen.dart
import 'package:flutter/material.dart';
import 'package:uptodo/utils/colors.dart';
import 'package:uptodo/utils/text_styles.dart';
import 'package:uptodo/models/task_model.dart';
import 'package:uptodo/resusable_widgets/task_card.dart';
import 'package:uptodo/utils/dummy_data.dart';

class HomeScreen extends StatelessWidget {
  final bool empty;
  const HomeScreen({super.key, required this.empty});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.filter_list),
                Text(
                  "Index",
                  style: s16RegWhite87.copyWith(fontSize: 20),
                ),
                const CircleAvatar(
                  radius: 25,
                  child: Image(
                    image: AssetImage('assets/images/profile_pic.png'),
                  ),
                ),
              ],
            ),
            empty
                ? Column(
                    children: [
                      const SizedBox(height: 50),
                      const Image(
                        image: AssetImage('assets/images/home_checklist.png'),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'What do you want to do Today?',
                        style: s16RegWhite87.copyWith(fontSize: 20),
                      ),
                      const SizedBox(height: 15),
                      Text('Tap + to add tasks', style: s16RegWhite87),
                    ],
                  )
                : Column(
                    children: [
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 48,
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search_rounded,
                                color: hintColor, size: 30),
                            hintText: "Search for your task...",
                            hintStyle: s16RegWhite40.copyWith(color: hintColor),
                            filled: true,
                            fillColor: const Color(0xff1D1D1D),
                          ),
                          style: s16RegWhite40.copyWith(color: appWhite),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 31,
                            padding: const EdgeInsets.all(7),
                            decoration: const BoxDecoration(
                              color: white21,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Today",
                                    style: s16RegWhite87.copyWith(fontSize: 12),
                                  ),
                                  const SizedBox(width: 5),
                                  const Icon(Icons.arrow_drop_down_outlined,
                                      color: white87, size: 16),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 7.5),
                      // Use the tasks from DummyData
                      ...DummyData.tasks.map((task) => TaskCard(task: task)),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 31,
                            padding: const EdgeInsets.all(7),
                            decoration: const BoxDecoration(
                              color: white21,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Completed",
                                    style: s16RegWhite87.copyWith(fontSize: 12),
                                  ),
                                  const SizedBox(width: 5),
                                  const Icon(Icons.arrow_drop_down_outlined,
                                      color: white87, size: 16),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 7.5),

                      TaskCard(
                        task: Task(
                          title: 'Business meeting with the CEO',
                          time: '08:15',
                        ),
                      ),
                    ],
                  )
          ],
        ),
      )),
    );
  }
}
