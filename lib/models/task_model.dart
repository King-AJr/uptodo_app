import 'package:flutter/material.dart';
import 'package:uptodo/models/categories_models.dart';

class Task {
  final String title;
  final String time;
  final Category? taskCategory;
  final int? priority;
  final String? description;
  Task({
    this.description,
    this.priority,
    required this.title,
    required this.time,
    this.taskCategory,
  });
}
