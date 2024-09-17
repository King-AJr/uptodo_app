import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uptodo/models/categories_models.dart';
import 'package:uptodo/models/task_model.dart';
import 'package:uptodo/resusable_widgets/alerts.dart';
import 'package:uptodo/utils/server.dart';
import 'package:uptodo/views/bottom_nav_bar.dart';

class TaskVm extends ChangeNotifier {
  DateTime? selectedDateTime;
  Category? selectedCategory;
  int? selectedPriority;
  final title = TextEditingController();
  final description = TextEditingController();
  TasksResponse? tasksResponse;

  unSet() {
    selectedCategory = null;
    selectedDateTime = null;
    selectedPriority = null;
    title.text = '';
    description.text = '';
  }

  Future<void> addTask(BuildContext context) async {
    final response = await Server().req('/tasks', type: 'post', data: {
      "title": title.text,
      "description": description.text,
      "category_id": selectedCategory!.id,
      'priority': selectedPriority,
      "time": selectedDateTime!.toIso8601String()
    });

    final Map<String, dynamic> body = json.decode(response.body);
    if (body['success'] == true) {
      successAlert(body['message']);
      unSet();
      Get.to(() => BottomNavBar());
    } else {
      errorAlert('Sorry something went wrong');
      print(body['message']);
    }

    return;
  }

  Future<TasksResponse?> getTask(BuildContext context,
      {Map<String, dynamic>? filter}) async {
    final response =
        await Server().req('/all_tasks', type: 'post', data: filter);

    final Map<String, dynamic> body = json.decode(response.body);

    tasksResponse = TasksResponse.fromJson(body);

    return tasksResponse;
  }
}
