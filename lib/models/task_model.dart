import 'package:flutter/material.dart';
import 'package:uptodo/models/categories_models.dart';

class Task {
  final String title;
  final String time;
  final Color? tagColor;
  final Category? taskCategory;
  final int? priority;
  final String? description;
  Task({
    this.description,
    this.priority,
    required this.title,
    required this.time,
    this.tagColor,
    this.taskCategory,
  });
}
