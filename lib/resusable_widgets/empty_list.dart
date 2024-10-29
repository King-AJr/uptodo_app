import 'package:flutter/material.dart';
import 'package:uptodo/utils/text_styles.dart';

class EmptyList extends StatelessWidget {
  final String? message;
  const EmptyList({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        const Image(
          image: AssetImage('assets/images/home_checklist.png'),
        ),
        const SizedBox(height: 20),
        Text(
          message ?? 'What do you want to do Today?',
          style: s16RegWhite87.copyWith(fontSize: 20),
        ),
        const SizedBox(height: 15),
        Text('Tap + to add tasks', style: s16RegWhite87),
      ],
    );
  }
}
