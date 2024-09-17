import 'dart:convert';

import 'package:flutter/material.dart';

class CategoryResponse {
  final bool? success;
  final List<Category>? categories;

  CategoryResponse({
    this.success,
    this.categories,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    final categories = (json['categories'] as List?)
        ?.map((dynamic e) => Category.fromJson(e as Map<String, dynamic>))
        .where((category) => category.id != null)
        .toList();

    return CategoryResponse(
      success: json['success'] as bool?,
      categories: categories,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'categories': categories?.map((e) => e.toJson()).toList(),
      };
}

class Category {
  final int? id;
  final String name;
  final Color color;
  final Icon icon;

  Category({
    this.id,
    required this.name,
    required this.color,
    required this.icon,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      'name': name,
      'color': '#${color.value.toRadixString(16).padLeft(6, '0')}',
      'icon': jsonEncode(
        {
          'name': icon.icon!.codePoint,
          'color':
              '#${(icon.color ?? Colors.black).value.toRadixString(16).padLeft(6, '0')}',
        },
      )
    };
  }

  factory Category.fromJson(Map<String, dynamic> data) {
    
    final icon = json.decode(data['icon']);
    final iconName = icon['name'] as int;
    final iconColor = icon['color'] as String;

    Color parseColor(String colorString) {
      if (colorString.startsWith('#')) {
        colorString = colorString.substring(1);
      }
      if (colorString.length == 6) {
        colorString = 'FF$colorString';
      }
      return Color(int.parse(colorString, radix: 16));
    }

    return Category(
      id: data['id'],
      name: data['name'],
      color: parseColor(data['color']),
      icon: Icon(
        IconData(
          iconName,
          fontFamily: 'MaterialIcons',
        ),
        color: parseColor(iconColor),
      ),
    );
  }
}
