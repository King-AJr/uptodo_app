import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String label;
  final String hint;

  const CustomTextfield({super.key, required this.label, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 10),
        TextFormField(
          decoration: InputDecoration(hintText: hint),
        )
      ],
    );
  }
}
