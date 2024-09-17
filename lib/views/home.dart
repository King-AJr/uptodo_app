import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uptodo/resusable_widgets/empty_list.dart';
import 'package:uptodo/utils/colors.dart';
import 'package:uptodo/utils/helperFunctions.dart';
import 'package:uptodo/utils/text_styles.dart';
import 'package:uptodo/models/task_model.dart';
import 'package:uptodo/resusable_widgets/task_card.dart';
import 'package:uptodo/view-models/task_vm.dart';

class HomeScreen extends StatelessWidget {
  final bool empty;
  const HomeScreen({super.key, required this.empty});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TaskVm>(context);
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
              FutureBuilder(
                future: vm.getTask(context,
                    filter: {'today': true, 'completed': false}),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Loader();
                  }
                  TasksResponse res = snapshot.data;
                  if (res.tasks!.isEmpty || res.tasks![0].id == null) {
                    return const EmptyList();
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      Container(
                        height: 37,
                        width: 76,
                        decoration: BoxDecoration(
                          color: white21,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Today',
                              style: s16RegWhite87.copyWith(fontSize: 12),
                            ),
                            const SizedBox(width: 5),
                            const Icon(
                              Icons.expand_more_outlined,
                              color: white87,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: res.tasks?.length,
                        itemBuilder: (BuildContext context, int index) {
                          Task task = res.tasks![index];
                          return TaskCard(task: task);
                        },
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              FutureBuilder(
                future: vm.getTask(context, filter: {'completed': true}),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Loader();
                  }
                  TasksResponse res = snapshot.data;
                  if (res.tasks!.isEmpty || res.tasks![0].id == null) {
                    return const SizedBox();
                  }
                  return Column(
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
                        itemCount: res.tasks?.length,
                        itemBuilder: (BuildContext context, int index) {
                          Task task = res.tasks![index];
                          return TaskCard(task: task);
                        },
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
