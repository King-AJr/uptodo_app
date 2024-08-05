import 'package:flutter/material.dart';
import 'package:uptodo/constants/colors.dart';

class OnboardingButton extends StatelessWidget {
  final double? height;
  final double? width;
  final Text child;
  final Color? color;
  const OnboardingButton(
      {super.key,
      this.width = 90,
      this.height = 48,
      required this.child,
      this.color = appPurple});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: child);
  }
}
