import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:uptodo/models/categories_models.dart';
import 'package:uptodo/resusable_widgets/alerts.dart';
import 'package:uptodo/utils/colors.dart';
import 'package:uptodo/utils/server.dart';
import 'package:uptodo/view-models/auth_vm.dart';
import 'package:uptodo/views/bottom_nav_bar.dart';

class CategoryVm extends ChangeNotifier {
  CategoryResponse? categories;
  final name = TextEditingController();
  IconData? icon;
  Color? color;
  Color? iconColor;

  Future getCategories() async {
    try {
      final response = await Server().req('/all_categories');
      final parsed = json.decode(response.body);
      categories = CategoryResponse.fromJson(parsed);
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  addCategory(BuildContext context) async {
    try {
      final userId =
          Provider.of<AuthVm>(context, listen: false).userResponse?.id;

      final categoryData = Category(
        name: name.text,
        color: color ?? primaryColor,
        icon: Icon(icon, color: iconColor),
      ).toJson();

      final response = await Server().req('/add_categories',
          type: 'post', data: {...categoryData, 'user_id': userId});

      final Map<String, dynamic> body = json.decode(response.body);

      if (body['success']) {
        successAlert('Category added successfully');
        Get.to(() => BottomNavBar());
      } else {
        errorAlert('Something went wrong please try again');
      }
    } catch (e) {
      errorAlert(e.toString());
    }
  }
}
