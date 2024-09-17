import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uptodo/utils/colors.dart';
import 'package:uptodo/utils/getit.dart';
import 'package:uptodo/utils/storage.dart';
import 'package:uptodo/utils/text_styles.dart';
import 'package:uptodo/views/onboarding.dart';
import 'package:uptodo/views/redirect.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
    onBoard();
  }

  void onBoard() async {
    await Future.delayed(const Duration(seconds: 3), () {
      
    final token = getIt.get<LocalStorageService>().getString("token");
    if (token == null || token == '') {
      Get.offAll(() => const OnboardingScreen());
      return;
    }
    Get.offAll(() => const Redirect());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: bgColor,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
                image: AssetImage('assets/images/logo.png'),
                width: 95.03,
                height: 80.46),
            const SizedBox(height: 25),
            Text(
              'UpTodo',
              style: logoText,
            ),
          ],
        ),
      ),
    );
  }
}
