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
  bool? completed;
  final String? description;
  final String? updatedAt;
  Task({
    this.id,
    this.completed,
    this.updatedAt,
    this.description,
    this.priority,
    required this.title,
    required this.time,
    this.taskCategory,
  });

  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        updatedAt = json['updated_at'] as String?,
        title = json['title'] as String?,
        description = json['description'] as String?,
        priority = json['priority'] as int?,
        completed = json['completed'] == 1 ? true : false as bool?,
        time = json['time'] as String?,
        taskCategory = (json['category'] as Map<String, dynamic>?) != null
            ? Category.fromJson(json['category'] as Map<String, dynamic>)
            : null;
}
