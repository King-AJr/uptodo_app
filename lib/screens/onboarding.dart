import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:introduction_screen/introduction_screen.dart';
import 'package:uptodo/constants/colors.dart';
import 'package:uptodo/constants/text_styles.dart';
import 'package:uptodo/resusable_widgets/onboarding_button.dart';
import 'package:uptodo/screens/start_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        leading: Container(
          padding: const EdgeInsets.only(left: 16, top: 20),
          child: GestureDetector(
            onTap: () {
              Get.to(() => const StartScreen());
            },
            child: Text(
              'SKIP',
              style: s16RegWhite40,
            ),
          ),
        ),
      ),
      body: IntroductionScreen(
        globalBackgroundColor: bgColor,
        controlsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 60),
        pages: [
          PageViewModel(
            title: '',
            bodyWidget: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              color: bgColor,
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/images/onboard1.png'),
                        width: 213,
                        height: 277.28,
                      ),
                    ],
                  ),
                  const SizedBox(height: 80),
                  Text('Manage your tasks', style: s32BoldWhite),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                        textAlign: TextAlign.center,
                        'You can easily manage all of your daily tasks in DoMe for free',
                        style: s16RegWhite87),
                  ),
                ],
              ),
            ),
          ),
          PageViewModel(
            title: '',
            bodyWidget: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              color: bgColor,
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/images/onboard2.png'),
                        width: 213,
                        height: 277.28,
                      ),
                    ],
                  ),
                  const SizedBox(height: 80),
                  Text('Create daily routine', style: s32BoldWhite),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                        textAlign: TextAlign.center,
                        'In Uptodo  you can create your personalized routine to stay productive',
                        style: s16RegWhite87),
                  ),
                ],
              ),
            ),
          ),
          PageViewModel(
            title: '',
            bodyWidget: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              color: bgColor,
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/images/onboard3.png'),
                        width: 213,
                        height: 277.28,
                      ),
                    ],
                  ),
                  const SizedBox(height: 80),
                  Text('Organize your tasks', style: s32BoldWhite),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                        textAlign: TextAlign.center,
                        'You can organize your daily tasks by adding your tasks into separate categories',
                        style: s16RegWhite87),
                  ),
                ],
              ),
            ),
          ),
        ],
        showDoneButton: true,
        done: OnboardingButton(
          width: 200,
          child: Text(
            "DONE",
            style: s16RegWhite40.copyWith(color: appWhite),
          ),
        ),
        next: OnboardingButton(
          child: Text(
            "NEXT",
            style: s16RegWhite40.copyWith(color: appWhite),
          ),
        ),
        back: OnboardingButton(
          color: bgColor,
          child: Text(
            "BACK",
            style: s16RegWhite40,
          ),
        ),
        dotsDecorator: DotsDecorator(
          color: bgColor,
          activeColor: primaryColor,
          size: const Size.square(10),
          activeSize: const Size(22, 10),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        showNextButton: true,
        showBackButton: true,
        onDone: () {
          Get.to(() => const StartScreen());
        },
      ),
    );
  }
}
