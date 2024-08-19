import 'package:flutter/material.dart';
import 'package:uptodo/views/bottom_nav_bar.dart';
import 'package:uptodo/views/intro.dart';
import 'package:uptodo/views/onboarding.dart';
import 'package:get/get.dart';
import 'package:uptodo/utils/themes/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My Flutter App',
      themeMode: ThemeMode.system,
      theme: myAppTheme.myThemes,
      initialRoute: '/intro',
      routes: {
        '/intro': (context) => const IntroScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/BottomNavBar': (context) => BottomNavBar()
      },
    );
  }
}
