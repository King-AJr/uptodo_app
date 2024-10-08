import 'package:flutter/material.dart';
import 'package:uptodo/utils/colors.dart';
import 'package:uptodo/utils/text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String label;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  CustomTextField(
      {required this.hintText,
      this.isPassword = false,
      required this.label,
      this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: s16RegWhite40.copyWith(color: appWhite),
          ),
          const SizedBox(height: 15),
          TextFormField(
            validator: validator,
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: s16RegWhite40.copyWith(color: hintColor),
              filled: true,
              fillColor: Colors.black12,
            ),
            style: s16RegWhite40.copyWith(color: appWhite),
          ),
        ],
      ),
    );
  }
}
