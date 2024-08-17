// dummy_data.dart
import 'package:flutter/material.dart';
import 'package:uptodo/constants/colors.dart';
import 'package:uptodo/models/categories_models.dart';
import 'package:uptodo/models/focus_model.dart';
import 'package:uptodo/models/task_model.dart';

class DummyData {
  static List<Category> categories = [
    Category(
      name: 'Grocery',
      color: const Color(0xffCCFF80),
      icon: const Icon(Icons.lunch_dining_outlined, color: Color(0xff21A300)),
    ),
    Category(
      name: 'Work',
      color: appOrange,
      icon:
          const Icon(Icons.business_center_outlined, color: Color(0xffA36200)),
    ),
    Category(
      name: 'Sport',
      color: const Color(0xff80FFFF),
      icon: const Icon(Icons.fitness_center_outlined, color: Color(0xff00A32F)),
    ),
    Category(
      name: 'Design',
      color: const Color(0xff80FFD9),
      icon:
          const Icon(Icons.business_center_outlined, color: Color(0xff00A372)),
    ),
    Category(
      name: 'University',
      color: appPurple,
      icon: const Icon(Icons.school_outlined, color: Color(0xff0055A3)),
    ),
    Category(
      name: 'Personal',
      color: const Color(0xffFF80EB),
      icon: const Icon(Icons.person_outline, color: Color(0xffA30089)),
    ),
    Category(
      name: 'Create New',
      color: const Color(0xff80FFD1),
      icon: const Icon(Icons.add, color: Color(0xff00A369)),
    ),
  ];

  static List<Task> tasks = [
    Task(
      title: 'Do Math Homework',
      time: '16:45',
      tagColor: tagPurple,
      taskCategory: 'University',
      tagIcon: const Icon(Icons.school_outlined, color: Color(0xff0055A3)),
      priority: 1,
      description: 'Complete chapter 5 exercises',
    ),
    Task(
      title: 'Take out Dogs',
      time: '18:20',
      tagColor: appOrange,
      taskCategory: 'Home',
      tagIcon: const Icon(Icons.home_outlined, color: Color(0xffA30000)),
      priority: 2,
      description: 'Walk the dogs for 30 minutes',
    ),
    Task(
      title: 'Business meeting with the CEO',
      time: '08:15',
      tagColor: appYellow,
      taskCategory: 'Work',
      tagIcon:
          const Icon(Icons.business_center_outlined, color: Color(0xffA36200)),
      priority: 3,
      description: 'Discuss Q3 performance and strategies',
    ),
  ];

  static List<FocusMode> focusData = [
    FocusMode('SUN', 2.5),
    FocusMode('MON', 3.5),
    FocusMode('TUE', 5.0),
    FocusMode('WED', 3.0),
    FocusMode('THU', 4.0),
    FocusMode('FRI', 4.5),
    FocusMode('SAT', 2.0),
  ];
}