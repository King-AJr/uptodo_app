import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uptodo/resusable_widgets/custom_textfield.dart';
import 'package:uptodo/utils/colors.dart';
import 'package:uptodo/utils/text_styles.dart';
import 'package:uptodo/utils/validators.dart';
import 'package:uptodo/view-models/auth_vm.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AuthVm>(context);
    vm.unSet();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text(
          'Reset Password',
          style: s20BoldWhite87.copyWith(fontFamily: 'latoRegular'),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CustomTextField(
                hintText: 'Enter Old Password',
                label: 'Old Password',
                controller: vm.oldPassword,
              ),
              CustomTextField(
                hintText: 'Enter New Password',
                label: 'New Password',
                controller: vm.password,
                validator: (value) => validatePassword(value),
              ),
              CustomTextField(
                hintText: 'Confirm New Password',
                label: 'Confirm Password',
                controller: vm.cpassword,
                validator: (value) => confirmPassword(vm.password.text, value),
              ),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: () {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }
                  vm.updatePassword(context);
                },
                child: const Text('Reset'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
