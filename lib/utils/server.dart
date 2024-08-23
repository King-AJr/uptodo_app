import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:uptodo/resusable_widgets/alerts.dart';
import 'package:uptodo/resusable_widgets/network_error.dart';
import 'package:uptodo/utils/getit.dart';
import 'package:uptodo/utils/storage.dart';
import 'package:uptodo/views/login.dart';
import 'package:http/http.dart' as http;


const baseUrl = "http://127.0.0.1:8000";
const _url = '$baseUrl/api';

class Server {
  String? token;

  _getToken() async {
    token = getIt.get<LocalStorageService>().getString("token");
  }

  authData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  req(apiUrl, {String? type = 'get', data}) async {
    var fullUrl = _url + apiUrl;
    var response;
    try {
      await _getToken();
      if (type == 'post') {
        response = await http.post(Uri.parse(fullUrl),
            body: jsonEncode(data), headers: _setHeaders());
      } else {
        response = await http.get(Uri.parse(fullUrl), headers: _setHeaders());
        // print(response.statusCode);
      }

      if (response.statusCode == 401) {
        errorAlert('Session expired');
        await Get.offAll(() => const LoginScreen());
        await Future.delayed(const Duration(seconds: 2));
      } else if (response.statusCode == 500) {
        errorAlert('An error occured, please try again');
      }
    } on SocketException {
      await Get.offAll(() => const NetworkError());
      errorAlert('No internet connection');
      await Future.delayed(const Duration(seconds: 3));
    }
    return response;
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
}
