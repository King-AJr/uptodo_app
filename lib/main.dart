import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uptodo/utils/getit.dart';
import 'package:uptodo/view-models/auth_vm.dart';
import 'package:uptodo/view-models/category_vm.dart';
import 'package:uptodo/view-models/task_vm.dart';
import 'package:uptodo/views/bottom_nav_bar.dart';
import 'package:uptodo/views/intro.dart';
import 'package:uptodo/views/onboarding.dart';
import 'package:get/get.dart';
import 'package:uptodo/utils/themes/themes.dart';

void main() async {
  await setup();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthVm()),
        ChangeNotifierProvider(create: (_) => TaskVm()),
         ChangeNotifierProvider(create: (_) => CategoryVm()),
      ],
      child: const MyApp(),
    ),
  );
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
