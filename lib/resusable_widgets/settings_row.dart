import 'package:flutter/material.dart';
import 'package:uptodo/utils/colors.dart';
import 'package:uptodo/utils/text_styles.dart';

class SettingsRow extends StatelessWidget {
  final Icon icon;
  final String title;
  final void Function()? onPressed;
  const SettingsRow({super.key, required this.icon, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context, ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              icon,
              const SizedBox(width: 10),
              Text(title, style: s16RegWhite87),
            ],
          ),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.arrow_forward_ios_outlined,
                size: 24, color: appWhite),
          ),
        ],
      ),
    );;
  }
}