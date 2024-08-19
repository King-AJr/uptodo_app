import 'package:flutter/material.dart';
import 'package:uptodo/utils/colors.dart';
import 'package:uptodo/utils/themes/elevated_button_themes.dart';
import 'package:uptodo/utils/themes/outline_button_themes.dart';
import 'package:uptodo/utils/themes/textformfield_theme.dart';

class myAppTheme {
  myAppTheme._();

  static ThemeData myThemes = ThemeData(
      useMaterial3: false,
      brightness: Brightness.dark,
      primaryColor: bgColor,
      scaffoldBackgroundColor: bgColor,
      elevatedButtonTheme: MyElevatedButtonTheme.myElevatedButtonTheme,
      outlinedButtonTheme: MyOutlineButtonTheme.myOutlineButtonTheme,
      inputDecorationTheme: MyTextFieldTheme.MyInputDecorationTheme);
}
