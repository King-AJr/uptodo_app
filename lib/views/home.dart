import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uptodo/models/task_model.dart';
import 'package:uptodo/resusable_widgets/empty_list.dart';
import 'package:uptodo/resusable_widgets/task_card.dart';
import 'package:uptodo/utils/colors.dart';
import 'package:uptodo/utils/text_styles.dart';
import 'package:uptodo/view-models/task_vm.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TaskVm vm;

  @override
  void initState() {
    super.initState();
    vm = Provider.of<TaskVm>(context, listen: false);
    vm.fetchTasks(context, filter: {'today': true});
    vm.taskSearch.addListener(() {
      vm.filterTasks(vm.taskSearch.text);
    });
  }

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
              const SizedBox(height: 20),

              // Search Field
              SizedBox(
                height: 48,
                child: TextField(
                  controller: vm.taskSearch,
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

              // Incomplete Tasks
              Consumer<TaskVm>(
                builder: (context, vm, child) {
                  return vm.filteredIncompleteTasks.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 31,
                              width: 100,
                              padding: const EdgeInsets.all(7),
                              decoration: const BoxDecoration(
                                color: white21,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Today",
                                    style: s16RegWhite87.copyWith(fontSize: 12),
                                  ),
                                  const SizedBox(width: 5),
                                  const Icon(
                                    Icons.expand_more_outlined,
                                    color: white87,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: vm.filteredIncompleteTasks.length,
                              itemBuilder: (BuildContext context, int index) {
                                Task task = vm.filteredIncompleteTasks[index];
                                return TaskCard(task: task);
                              },
                            ),
                          ],
                        )
                      : const EmptyList();
                },
              ),
              const SizedBox(height: 20),

              // Completed Tasks
              Consumer<TaskVm>(
                builder: (context, vm, child) {
                  return vm.filteredCompletedTasks.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 31,
                              width: 100,
                              padding: const EdgeInsets.all(7),
                              decoration: const BoxDecoration(
                                color: white21,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Completed",
                                    style: s16RegWhite87.copyWith(fontSize: 12),
                                  ),
                                  const SizedBox(width: 5),
                                  const Icon(
                                    Icons.expand_more_outlined,
                                    color: white87,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: vm.filteredCompletedTasks.length,
                              itemBuilder: (BuildContext context, int index) {
                                Task task = vm.filteredCompletedTasks[index];
                                return TaskCard(task: task);
                              },
                            ),
                          ],
                        )
                      : const SizedBox();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
