import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uptodo/constants/colors.dart';
import 'package:uptodo/constants/text_styles.dart';
import 'package:uptodo/screens/login.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        leading: const Icon(Icons.arrow_back_ios_new_outlined),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text('Welcome to UpTodo', style: s32BoldWhite),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    'Please login to your account or create new account to continue',
                    style: s16RegWhite40.copyWith(color: white67),
                  ),
                )
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => LoginScreen());
                    },
                    child: Text('LOGIN',
                        style: s16RegWhite40.copyWith(color: appWhite)),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text('CREATE ACCOUNT',
                        style: s16RegWhite40.copyWith(color: appWhite)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
