import 'package:flutter/material.dart';
import 'package:uptodo/constants/colors.dart';
import 'package:uptodo/constants/text_styles.dart';
import 'package:uptodo/resusable_widgets/task_card.dart';

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
                      const TaskCard(
                        title: 'Do Math Homework',
                        time: '16:45',
                        tagColor: tagPurple,
                        taskCategory: 'University',
                        tagIcon: Icon(Icons.school_outlined,
                            color: Color(0xff0055A3), size: 12),
                        priority: 1,
                      ),
                      const TaskCard(
                        title: 'Take out Dogs',
                        time: '18:20',
                        tagColor: appOrange,
                        taskCategory: 'Home',
                        tagIcon: Icon(Icons.home_outlined,
                            color: Color(0xffA30000), size: 12),
                        priority: 2,
                      ),
                      const TaskCard(
                        title: 'Business meeting with the CEO',
                        time: '08:15',
                        tagColor: appYellow,
                        taskCategory: 'Work',
                        tagIcon: Icon(Icons.business_center_outlined,
                            color: Color(0xffA36200), size: 12),
                        priority: 3,
                      ),
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
                      const TaskCard(
                        title: 'Business meeting with the CEO',
                        time: '08:15',
                      ),
                    ],
                  )
          ],
        ),
      )),
    );
  }
}
