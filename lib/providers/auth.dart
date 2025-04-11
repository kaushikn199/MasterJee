import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/login/login_data.dart';
import 'package:http/http.dart' as http;
import 'package:masterjee/others/ApiHelper.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/screens/signup_screen.dart';

class Auth with ChangeNotifier {

  Future<LoginData> login(String username, String password) async {
    Map<String, dynamic> body = {
      'email': username.trim(),
      'password': password.trim(),
    };

    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.login, body);
    print("responseData : ${responseData}");

    if (responseData['data'] != null) {
      return LoginData.fromJson(responseData);
    } else {
      throw Exception(responseData['message'] ?? 'Login failed');
    }
  }

  Future<void> logout(cntx) async {
    await StorageHelper.clearUserData();
    Get.offAllNamed(SignupScreen.routeName);
   //Navigator.of(cntx).pushNamed(SignupScreen.routeName,);
  }

}