import 'package:flutter/material.dart';
import 'package:uptodo/utils/colors.dart';
import 'package:uptodo/utils/text_styles.dart';

class FocusAppCard extends StatelessWidget {
  final String appName;
  final String hours;
  final String imageUrl;
  const FocusAppCard({
    super.key,
    required this.appName,
    required this.hours,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: focusAppCard,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset("assets/images/$imageUrl", height: 32, width: 32),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appName,
                    style: s14MedWhite87.copyWith(color: appWhite),
                  ),
                  Text(
                    "You spent $hours on $appName today",
                    style: s14MedWhite87.copyWith(color: appWhite),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Container(width: 2, height: double.infinity, color: greyBorder),
              const SizedBox(width: 15),
              const Icon(Icons.error_outline_rounded,
                  color: appWhite, size: 24),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }
}
