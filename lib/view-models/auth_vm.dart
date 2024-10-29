import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uptodo/models/user_model.dart';
import 'package:uptodo/resusable_widgets/alerts.dart';
import 'package:uptodo/utils/getit.dart';
import 'package:uptodo/utils/helperFunctions.dart';
import 'package:uptodo/utils/server.dart';
import 'package:uptodo/utils/storage.dart';
import 'package:uptodo/views/bottom_nav_bar.dart';
import 'package:uptodo/views/redirect.dart';

class AuthVm extends ChangeNotifier {
  final name = TextEditingController();
  final password = TextEditingController();
  final cpassword = TextEditingController();
  final oldPassword = TextEditingController();
  final localStorage = getIt.get<LocalStorageService>();

  User? userResponse;

  unSet() {
    name.text = '';
    password.text = '';
    cpassword.text = '';
    oldPassword.text = '';
  }

  Future<void> register(BuildContext context) async {
    FullScreenLoader.openLoadingDialog('We are processing you information...');

    final response = await Server().authData({
      'password': password.text,
      'name': name.text,
    }, '/register');
    final Map<String, dynamic> body = json.decode(response.body);
    if (response.statusCode == 422) {
      errorAlert(body['message'].toString(), title: body['error']);
      FullScreenLoader.stopLoader();
      return;
    }

    if (body['token'] != null) {
      FullScreenLoader.stopLoader();
      localStorage.setString("token", body['token']);
      await Get.to(() => const Redirect());
    } else {
      errorAlert(body['message']);
    }

    FullScreenLoader.stopLoader();
  }

  Future<void> login(BuildContext context) async {
    FullScreenLoader.openLoadingDialog('We are processing you information...');

    final response = await Server().authData({
      'password': password.text,
      'name': name.text,
    }, '/login');
    final Map<String, dynamic> body = json.decode(response.body);

    if (body['success'] == false) {
      errorAlert(body['message'].toString(), title: body['error']);
      FullScreenLoader.stopLoader();
      return;
    }

    if (body['token'] != null) {
      FullScreenLoader.stopLoader();
      localStorage.setString("token", body['token']);

      await Get.to(() => const Redirect());
    } else {
      errorAlert(body['message']);
    }

    FullScreenLoader.stopLoader();
  }

  Future<void> googleLogin(BuildContext context, data) async {
    FullScreenLoader.openLoadingDialog('We are processing you information...');

    final response =
        await Server().req('/google_login', type: 'post', data: data);

    final Map<String, dynamic> body = json.decode(response.body);

    if (body['success'] == true && body['token'] != null) {
      FullScreenLoader.stopLoader();
      localStorage.setString("token", body['token']);

      successAlert('Logged in successfully');
      await Get.to(() => const Redirect());
    }
  }

  Future getUser(
      {bool redirect = false,
      bool authPin = true,
      bool checkVersion = true}) async {
    final resp = await Server().req('/user');
    final Map<String, dynamic> parsed = json.decode(resp.body);
    userResponse = User.fromJson(parsed);

    if (!redirect) {
      return userResponse;
    }

    await Get.offAll(() => const BottomNavBar());
  }

  Future updatePassword(BuildContext context) async {
    if (password.text != cpassword.text) {
      errorAlert("Passwords do not match");
      return;
    }

    var loader = progressLoader(context);
    loader.show();

    final response = await Server().req(
        type: 'post',
        data: {
          'old_password': oldPassword.text,
          'password': password.text,
          'password_confirmation': cpassword.text,
        },
        '/account/update-password/api');

    final Map<String, dynamic> result = json.decode(response.body);
    loader.dismiss();
    if (result['success'] == true) {
      unSet();
      successAlert("Password updated");
      Get.to(() => const BottomNavBar());
    } else {
      errorAlert(result['message']);
    }
    return;
  }
}
