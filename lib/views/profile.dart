import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:uptodo/utils/colors.dart';
import 'package:uptodo/utils/sizes.dart';
import 'package:uptodo/utils/text_styles.dart';
import 'package:uptodo/resusable_widgets/account_name_dialog.dart';
import 'package:uptodo/resusable_widgets/change_image_modal.dart';
import 'package:uptodo/resusable_widgets/settings_row.dart';
import 'package:uptodo/view-models/auth_vm.dart';
import 'package:uptodo/view-models/task_vm.dart';
import 'package:uptodo/views/change_password.dart';
import 'package:uptodo/views/login.dart';
import 'package:uptodo/views/settings.dart';
import 'package:uptodo/utils/getit.dart';
import 'package:uptodo/utils/storage.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final avm = Provider.of<AuthVm>(context);
    final tvm = Provider.of<TaskVm>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text(
          'Profile',
          style: s20BoldWhite87.copyWith(fontFamily: 'latoRegular'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 85,
                    width: 85,
                    child: ClipOval(
                      child: Image(
                        image: AssetImage('assets/images/dp_pic.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(avm.userResponse!.name ?? '', style: s20BoldWhite87),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 58,
                      padding: const EdgeInsets.all(7),
                      decoration: const BoxDecoration(
                        color: white21,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${tvm.filteredIncompleteTasks.length} Task left today",
                              style: s16RegWhite87.copyWith(color: appWhite),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      height: 58,
                      padding: const EdgeInsets.all(7),
                      decoration: const BoxDecoration(
                        color: white21,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${tvm.filteredCompletedTasks.length} task done today",
                              style: s16RegWhite87.copyWith(color: appWhite),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Text(
                    'Settings',
                    style: s14MedWhite87.copyWith(
                        color: greyText, fontFamily: 'latoRegular'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SettingsRow(
                  icon: const Icon(Icons.settings_outlined,
                      size: 24, color: appWhite),
                  title: 'App Settings',
                  onPressed: () {
                    Get.to(() => const SettingScreen());
                  }),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Account',
                    style: s14MedWhite87.copyWith(
                        color: greyText, fontFamily: 'latoRegular'),
                  ),
                ],
              ),
              SettingsRow(
                  icon: const Icon(Icons.person_outline_outlined,
                      size: 24, color: appWhite),
                  title: 'Change account name',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const AccountNameDialog(),
                    );
                  }),
              SettingsRow(
                  icon: const Icon(
                    Icons.key_outlined,
                    size: 24,
                    color: appWhite,
                  ),
                  title: 'Change account password',
                  onPressed: () {
                    Get.to(() => const ChangePassword());
                  }),
              SettingsRow(
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                    size: 24,
                    color: appWhite,
                  ),
                  title: 'Change account image',
                  onPressed: () {
                    showAddImageModal(context);
                  }),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Uptodo',
                    style: s14MedWhite87.copyWith(
                        color: greyText, fontFamily: 'latoRegular'),
                  ),
                ],
              ),
              const SettingsRow(
                icon: Icon(
                  Icons.menu_book_outlined,
                  size: 24,
                  color: appWhite,
                ),
                title: 'About us',
              ),
              const SettingsRow(
                icon: Icon(
                  Icons.error_outline_outlined,
                  size: 24,
                  color: appWhite,
                ),
                title: 'FAQ',
              ),
              const SettingsRow(
                icon: Icon(
                  Icons.bolt_outlined,
                  size: 24,
                  color: appWhite,
                ),
                title: 'Helped & Feedback',
              ),
              const SettingsRow(
                icon: Icon(
                  Icons.thumb_up_alt_outlined,
                  size: 24,
                  color: appWhite,
                ),
                title: 'Support us',
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  await getIt.get<LocalStorageService>().setString('name', '');
                  await getIt.get<LocalStorageService>().setString('email', '');
                  await getIt.get<LocalStorageService>().setString('token', '');
                  Get.offAll(() => const LoginScreen());
                },
                child: Container(
                  color: bgColor,
                  child: Row(
                    children: [
                      const Icon(Icons.logout_outlined,
                          size: Sizes.iconSize, color: appRed),
                      const SizedBox(width: 10),
                      Text(
                        'Log out',
                        style: s16RegWhite40.copyWith(color: appRed),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
