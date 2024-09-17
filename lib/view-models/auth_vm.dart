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

class AuthVm extends ChangeNotifier {
  final name = TextEditingController();
  final password = TextEditingController();
  final cpassword = TextEditingController();
  final localStorage = getIt.get<LocalStorageService>();

  User? userResponse;

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
      await Get.offAll(() => BottomNavBar());
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

      await Get.offAll(() => BottomNavBar());
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
      await Get.to(() => BottomNavBar());
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

    await Get.offAll(() => BottomNavBar());
  }
}
