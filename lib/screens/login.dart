import 'package:flutter/material.dart';
import 'package:uptodo/constants/colors.dart';
import 'package:uptodo/constants/text_styles.dart';
import 'package:uptodo/resusable_widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        body: const SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            child:
                CustomTextfield(hint: 'Enter your username', label: 'Username'),
          ),
        ));
  }
}
