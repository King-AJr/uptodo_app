import 'package:flutter/material.dart';
import 'package:uptodo/constants/colors.dart';

class MyElevatedButtonTheme {
  MyElevatedButtonTheme._();

  static final myElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: appPurple,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      fixedSize: const Size(150, 48),
    ),
  );
}
