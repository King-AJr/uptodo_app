import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uptodo/utils/colors.dart';
import 'package:uptodo/utils/google_signin.dart';
import 'package:uptodo/utils/text_styles.dart';
import 'package:uptodo/resusable_widgets/custom_textfield.dart';
import 'package:uptodo/utils/validators.dart';
import 'package:uptodo/view-models/auth_vm.dart';
import 'package:uptodo/views/bottom_nav_bar.dart';
import 'package:uptodo/views/login.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AuthVm>(context);
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
            key: formKey,
            child: Column(
              children: [
                CustomTextField(
                    controller: vm.name,
                    label: "Username",
                    hintText: "Enter your username",
                    isPassword: false,
                    validator: (value) => validateUsername(value)),
                CustomTextField(
                    controller: vm.password,
                    label: "Password",
                    hintText: "********",
                    isPassword: true,
                    validator: (value) => validatePassword(value)),
                CustomTextField(
                  controller: vm.cpassword,
                  label: "Confirm Password",
                  hintText: "********",
                  isPassword: true,
                  validator: (value) {
                    return confirmPassword(vm.password.text, value ?? '');
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }
                      vm.register(context);
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
                    onPressed: () async {
                      final googleUser = await googleSignIn();
                      vm.googleLogin(context, googleUser);
                    },
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
