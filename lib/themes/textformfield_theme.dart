import 'package:flutter/material.dart';
import 'package:uptodo/constants/colors.dart';

class MyTextFieldTheme {
  MyTextFieldTheme._();

  static InputDecorationTheme MyInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    labelStyle: const TextStyle().copyWith(
      fontSize: 16,
      fontFamily: "latoRegular",
      color: hintColor,
    ),
    hintStyle: const TextStyle().copyWith(
      fontSize: 16,
      fontFamily: "latoRegular",
      color: hintColor,
    ),
    errorStyle: const TextStyle().copyWith(
      fontSize: 16,
      fontFamily: "latoRegular",
      color: const Color(0xFFDB3022),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderSide: const BorderSide(
        width: 1,
        color: greyBorder,
      ),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderSide: const BorderSide(
        width: 1,
        color: greyBorder,
      ),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderSide: const BorderSide(
        width: 1,
        color: Color(0xFFDB3022),
      ),
    ),
  );
}
