import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uptodo/constants/colors.dart';
import 'package:uptodo/constants/text_styles.dart';
import 'package:uptodo/resusable_widgets/custom_textfield.dart';
import 'package:uptodo/screens/bottom_nav_bar.dart';
import 'package:uptodo/screens/login.dart';



class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            alignment: AlignmentDirectional.bottomStart,
            child: Text(
              'Register',
              style: s32BoldWhite.copyWith(color: white87),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            child: Column(
              children: [
                CustomTextField(
                  label: "Username",
                  hintText: "Enter your username",
                  isPassword: false,
                ),
                CustomTextField(
                  label: "Password",
                  hintText: "********",
                  isPassword: true,
                ),
                CustomTextField(
                  label: "Confirm Password",
                  hintText: "********",
                  isPassword: true,
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.offAll(() => BottomNavBar());
                    },
                    child: const Text('Register'),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(
                      child: Divider(
                        color: greyBorder,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'or',
                        style: s16RegWhite40.copyWith(color: greyBorder),
                      ),
                    ),
                    const Expanded(
                        child: Divider(color: greyBorder, thickness: 1)),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Image.asset('assets/images/google_logo.png'),
                        ),
                        const SizedBox(width: 10),
                        Text("Register with Google", style: s16RegWhite87),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Image.asset('assets/images/apple_logo.png'),
                        ),
                        const SizedBox(width: 10),
                        Text("Register with Apple", style: s16RegWhite87),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: s16RegWhite87.copyWith(color: greyBorder),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.off(() => const LoginScreen());
                        },
                        child: Text("Login",
                            style: s16RegWhite40.copyWith(color: appWhite)))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
