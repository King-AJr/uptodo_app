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
  final TextEditingController taskSearch = TextEditingController();

  List<Task> allTasks = [];
  List<Task> filteredIncompleteTasks = [];
  List<Task> filteredCompletedTasks = [];
  List<Task> dateTaskComplete = [];
  List<Task> dateTaskIncomplete = [];
  bool isLoading = false;

  void unSet() {
    selectedCategory = null;
    selectedDateTime = null;
    selectedPriority = null;
    title.text = '';
    description.text = '';
  }

  Future<void> addTask(BuildContext context) async {
    final response = await Server().req('/add_tasks', type: 'post', data: {
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
      notifyListeners();
      Get.to(() => BottomNavBar());
    } else {
      errorAlert('Sorry something went wrong');
      print(body['message']);
    }
  }

  Future<void> fetchTasks(BuildContext context,
      {Map<String, dynamic>? filter}) async {
    final response =
        await Server().req('/all_tasks', type: 'post', data: filter);

    final Map<String, dynamic> body = json.decode(response.body);

    allTasks = TasksResponse.fromJson(body).tasks ?? [];

    // Filter tasks initially
    filterTasks(taskSearch.text);
  }

  void filterTasks(String query) {
    filteredIncompleteTasks = allTasks.where((task) {
      bool isCompleted = task.completed ?? false;
      return !isCompleted &&
          (task.title?.toLowerCase().contains(query.toLowerCase()) ?? false);
    }).toList();

    filteredCompletedTasks = allTasks.where((task) {
      bool isCompleted = task.completed ?? false;
      return isCompleted &&
          (task.title?.toLowerCase().contains(query.toLowerCase()) ?? false);
    }).toList();

    notifyListeners();
  }

  deleteTask(int? id) async {
    final response = await Server().req('/delete_task/$id', type: 'post');
    final Map<String, dynamic> parsed = json.decode(response.body);
    if (parsed['success'] == true) {
      successAlert(parsed['message']);
      notifyListeners();
      Get.to(() => BottomNavBar());
    } else {
      errorAlert('Something went wrong');
    }
  }

  updateTask(Task task) async {
    print('${task.title} status ${task.completed}');
    final response =
        await Server().req('/update_task/${task.id}', type: 'post', data: {
      "title": task.title,
      "description": task.description,
      "category_id": task.taskCategory!.id,
      'priority': task.priority,
      "time": task.time,
      'completed': task.completed,
    });

    final Map<String, dynamic> body = json.decode(response.body);
    if (body['success'] == true) {
      successAlert(body['message']);
      unSet();
      notifyListeners();
      Get.to(() => BottomNavBar());
    } else {
      errorAlert('Sorry something went wrong');
      print(body['message']);
    }
  }

  fethchSpecificDate(BuildContext context, String? date) async {
    isLoading = true;
    print("date $date");
    final response =
        await Server().req('/all_tasks', type: 'post', data: {'date': date});

    final Map<String, dynamic> body = json.decode(response.body);

    if (body['success'] == true) {
      print(body);
      allTasks = TasksResponse.fromJson(body).tasks ?? [];

      dateTaskIncomplete = allTasks.where((task) {
        bool isCompleted = task.completed ?? false;
        return !isCompleted;
      }).toList();

      dateTaskComplete = allTasks.where((task) {
        bool isCompleted = task.completed ?? false;
        return isCompleted;
      }).toList();
      isLoading = false;
      notifyListeners();
    } else {
      errorAlert('Could not retrieve task please try again');
    }
  }
}
