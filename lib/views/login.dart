import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:uptodo/utils/colors.dart';
import 'package:uptodo/utils/google_signin.dart';
import 'package:uptodo/utils/text_styles.dart';
import 'package:uptodo/resusable_widgets/custom_textfield.dart';
import 'package:uptodo/utils/validators.dart';
import 'package:uptodo/view-models/auth_vm.dart';
import 'package:uptodo/views/register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AuthVm>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            alignment: AlignmentDirectional.bottomStart,
            child: Text(
              'Login',
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
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    label: "Username",
                    hintText: "Enter your username",
                    isPassword: false,
                    controller: vm.name,
                    validator: (value) => validateUsername(value)),
                CustomTextField(
                  label: "Password",
                  hintText: "********",
                  isPassword: true,
                  controller: vm.password,
                  validator: (value) => validatePassword(value),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }
                      vm.login(context);
                    },
                    child: const Text('Login'),
                  ),
                ),
                const SizedBox(height: 50),
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
                const SizedBox(height: 30),
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
                        Text("Login with Google", style: s16RegWhite87),
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
                        Text("Login with Apple", style: s16RegWhite87),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: s16RegWhite87.copyWith(color: greyBorder),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => const RegisterScreen());
                      },
                      child: Text(
                        "Register",
                        style: s16RegWhite40.copyWith(
                          color: appWhite,
                        ),
                      ),
                    ),
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
