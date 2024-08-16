import 'package:flutter/material.dart';

class Task {
  final String title;
  final String time;
  final Color? tagColor;
  final String? taskCategory;
  final Icon? tagIcon;
  final int? priority;
  final String? description;

  Task({
    required this.title,
    required this.time,
    this.tagColor,
    this.taskCategory,
    this.tagIcon,
    this.priority,
    this.description,
  });
}
