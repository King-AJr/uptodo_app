import 'package:uptodo/models/categories_models.dart';

class TasksResponse {
  final bool? success;
  final List<Task>? tasks;

  TasksResponse({this.success, this.tasks});

  TasksResponse.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool?,
        tasks = (json['tasks'] as List?)
            ?.map((dynamic e) => Task.fromJson(e as Map<String, dynamic>))
            .toList();
}

class Task {
  final int? id;
  final String? title;
  final String? time;
  final Category? taskCategory;
  final int? priority;
  final String? description;
  Task(
    this.id, {
    this.description,
    this.priority,
    required this.title,
    required this.time,
    this.taskCategory,
  });

  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        title = json['title'] as String?,
        description = json['description'] as String?,
        priority = json['priority'] as int?,
        time = json['time'] as String?,
        taskCategory = (json['category'] as Map<String, dynamic>?) != null
            ? Category.fromJson(json['category'] as Map<String, dynamic>)
            : null;
}
