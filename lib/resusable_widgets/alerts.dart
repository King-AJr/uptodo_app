// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uptodo/utils/colors.dart';

void errorAlert(String message, {String? title}) {
  Get.snackbar(
    title ?? 'Oops',
    message,
    colorText: appWhite,
    backgroundColor: Colors.redAccent,
    margin: EdgeInsets.all(15),
    snackPosition: SnackPosition.TOP,
    borderRadius: 15,
    icon: Icon(Icons.cancel, color: appRed, size: 40),
    padding: EdgeInsets.all(20),
  );
}

void successAlert(String message, {String? title}) {
  Get.snackbar(
    title ?? 'Awesome',
    message,
    colorText: Colors.white,
    backgroundColor: primaryColor,
    margin: EdgeInsets.all(15),
    snackPosition: SnackPosition.TOP,
    borderRadius: 15,
    icon: Icon(Icons.check_circle, color: appWhite, size: 40),
    padding: EdgeInsets.all(20),
  );
}
