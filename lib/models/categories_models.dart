import 'package:flutter/material.dart';

class Category {
  final String name;
  final Color color;
  final Icon icon;

  Category({
    required this.name,
    required this.color,
    required this.icon,
  });

  // Convert Category object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'color': '#${color.value.toRadixString(16).padLeft(6, '0')}',
      'icon': {
        'name': icon.icon!.codePoint.toString(),
        'color':
            '#${(icon.color ?? Colors.black).value.toRadixString(16).padLeft(6, '0')}',
      },
    };
  }

  // Create a Category object from JSON format
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
      color: Color(
          int.parse(json['color'].substring(1, 7), radix: 16) + 0xFF000000),
      icon: Icon(
        IconData(
          int.parse(json['icon']['name']),
          fontFamily: 'MaterialIcons',
        ),
        color: Color(
            int.parse(json['icon']['color'].substring(1, 7), radix: 16) +
                0xFF000000),
      ),
    );
  }
}
