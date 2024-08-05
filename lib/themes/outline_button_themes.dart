import 'package:flutter/material.dart';
import 'package:uptodo/constants/colors.dart';

class MyOutlineButtonTheme {
  MyOutlineButtonTheme._();

  static final myOutlineButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(
        color: purpleBorder,
        width: 1,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      fixedSize: const Size(150, 48),
    ),
  );
}
