// dummy_data.dart
import 'package:flutter/material.dart';
import 'package:uptodo/utils/colors.dart';
import 'package:uptodo/models/categories_models.dart';

class DummyData {
  static List<Category> categories = [
    Category(
      name: 'Grocery',
      color: const Color(0xffCCFF80),
      icon: const Icon(Icons.lunch_dining_outlined, color: Color(0xff21A300)),
    ),
    Category(
      name: 'Home',
      color: appRed,
      icon: const Icon(Icons.add, color: Color(0xffA30000)),
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

  
}
