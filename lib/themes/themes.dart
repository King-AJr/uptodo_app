import 'package:flutter/material.dart';
import 'package:uptodo/constants/colors.dart';
import 'package:uptodo/themes/elevated_button_themes.dart';
import 'package:uptodo/themes/outline_button_themes.dart';

class myAppTheme {
  myAppTheme._();

  static ThemeData myThemes = ThemeData(
      useMaterial3: false,
      brightness: Brightness.light,
      primaryColor: bgColor,
      scaffoldBackgroundColor: bgColor,
      elevatedButtonTheme: MyElevatedButtonTheme.myElevatedButtonTheme,
      outlinedButtonTheme: MyOutlineButtonTheme.myOutlineButtonTheme);
}
