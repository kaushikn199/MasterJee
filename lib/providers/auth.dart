import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  /*Future<User> login(String username, String password) async {
    var url = Uri.parse('${LocalDatabase.baseAPIUrl}auth/login');
    try {
      Map<String, String> body = {
        'username': username.trim(),
        'password': password.trim(),
        'device_token': Platform.isAndroid
            ? OneSignal.User.pushSubscription.id.toString()
            : "",
      };
      print(url);

      final response = await http.post(url, body: jsonEncode(body));
      print(response.statusCode);
      print(response.body);
      final responseData = json.decode(response.body);
      final userData = User.fromJson(responseData);
      return userData;
      // print(userData);
    } catch (error) {
      rethrow;
    }
  }*/

}